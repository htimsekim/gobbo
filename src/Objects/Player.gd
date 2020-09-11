class_name Player
extends Character

onready var Bullet = preload("res://src/Objects/projectile.tscn")
const FLOOR_DETECT_DISTANCE = 8.0 # < sprite height so player doesn't drop so fast from one block
onready var platform_detector = $PlatformDetector
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var canshoot = false
onready var timer = $ProjectileTimer
onready var blinktimer = $BlinkTimer
onready var knocktimer = $KnockbackTimer
onready var knockback = false
var direction

func _physics_process(_delta): # Called every frame. _delta isn't used
	if knockback == true and blinktimer.time_left == 0:
		sprite.visible = false
		blinktimer.start()
	
	direction = get_direction() #function determines if player is moving right or left
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	var is_on_platform = platform_detector.is_colliding()
	_velocity = move_and_slide_with_snap(_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false)
	var is_shooting = false #to determine if gun needs to be out and which animation to play

	if Input.is_action_pressed("shoot") or Input.is_action_pressed("stab"):
		is_shooting = true #we are shooting so be sure to play weapon animations
		if canshoot: #is true when the timer ends
			var b = Bullet.instance()
			Global.add_child(b)
			
			if Input.is_action_pressed("move_up"):
				b.position = $Sprite/shootpointu.global_position
				b.rotation_degrees = -90 * sprite.scale.x
			elif Input.is_action_pressed("crouch") and not is_on_floor():
				b.position = $Sprite/shootpointd.global_position
				b.rotation_degrees = 90 * sprite.scale.x
				_velocity.y = -150
			elif Input.is_action_pressed("crouch"):
				b.position = $Sprite/shootpointd.global_position
				b.rotation_degrees = 90 * sprite.scale.x
			else:
				b.position = $Sprite/shootpointx.global_position
				b.rotation_degrees = 0
			canshoot = false
			timer.start() #cannot shoot until timer ends
#	else:
#		get_tree().call_group("projectile","queue_free")
	
	if direction.x !=0: #apply friction(1) and acceleration(.2)
		sprite.scale.x = 1 if direction.x > 0 else -1 #flip player if going left and vice versa
		_velocity.x = lerp(_velocity.x, direction.x * speed.x, .2)
	else:
		_velocity.x = lerp(_velocity.x, 0, 1)
		
	var animation = get_new_animation(is_shooting) #determines which animation to play
	
	if animation != animation_player.current_animation:
		animation_player.play(animation)
	

	
func get_direction(): #determine if player is moving right or left
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1 if is_on_floor() and Input.is_action_just_pressed("jump") else 0)
	
# Calculates new velocity. It allows you to interrupt jumps.
func calculate_move_velocity(linear_velocity, cdirection, speed, is_jump_interrupted ):
	var velocity = linear_velocity

	if cdirection.y != 0.0: velocity.y = speed.y * cdirection.y
	if is_jump_interrupted: velocity.y = 0.0

	if linear_velocity.y < 15.5: #jump buffer between 15.5 and 15
		if Input.is_action_just_released("jump") or Input.is_action_just_pressed("jump"): 	
			velocity.y = speed.y * cdirection.y
			
	#fall through one way collision items
	if Input.is_action_just_pressed("jump") and Input.is_action_pressed("crouch") and is_on_floor(): 
		velocity.y = 0.0
		self.position = Vector2(self.position.x, self.position.y + 2)
		
	return velocity

func get_new_animation(is_shooting = false):
	var animation_new = ""
			
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "stand"
	else:
		animation_new = "airborne"

	if Input.is_action_pressed("crouch") and is_on_floor(): #only crouch while idle
		if abs(_velocity.x) < 0.1: animation_new = "crouch"

	if is_shooting: #add weapon animation to existing animation. ex run_armless
		animation_new += "shoot"		
		if Input.is_action_pressed("move_up") and !Input.is_action_pressed("crouch"):
			animation_new += "up"
		if Input.is_action_pressed("crouch") and animation_new == "airborneshoot":
			animation_new += "down"

	return animation_new

func _on_ProjectileTimer_timeout():
	canshoot = true

func playerdamage(damage): #damage, blink, and knockback player
	knockback = true #player hit, enable knockback effect

	if $TextureProgress.value <= 0: #if player is dead, end game DAMAGE
		#get_tree().quit()
		print("i died")
	else: #decrease player health
		$TextureProgress.value -= damage
	
	if sprite.scale.x == 1: #knockback code if player is right facing
		_velocity.x -= 700 #knockback 700 to the right
	if sprite.scale.x == -1: #knockback code if player is left facing
		_velocity.x += 700 #knockback 700 to the left
	_velocity.y -= 200 #height of knockback

	move_and_slide(_velocity) #knockback player

func _on_BlinkTimer_timeout(): #while knockback enabled, blink enemy
	sprite.visible = true
	blinktimer.stop()
