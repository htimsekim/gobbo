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
onready var idletimer = $IdleTimer
onready var knockback = false
var direction
var playeridle = false
var is_shooting
var enemyPos
var knocking = false

func _physics_process(_delta): # Called every frame. _delta isn't used
	if knockback == true and blinktimer.time_left == 0:
		sprite.visible = false
		blinktimer.start()
	
	direction = get_direction() #function determines if player is moving right or left

	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	var is_on_platform = platform_detector.is_colliding()
	if Input.is_action_pressed("crouch") and is_on_floor(): #don't move while crouching
		_velocity = Vector2(0,0)
	if knocking == true: #knockback code to set velocity
		_velocity = (Vector2(1,0).rotated(position.angle_to_point(enemyPos))*250)
		_velocity.y = _velocity.y/2
		_velocity.y -= 50
		snap_vector = Vector2(0,0)
		
	_velocity = move_and_slide_with_snap(_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false)
	is_shooting = false #to determine if gun needs to be out and which animation to play

	if Input.is_action_pressed("shoot") or Input.is_action_pressed("stab"):
		if get_node("../UI/reloadTimer").time_left == 0: 
			is_shooting = true #we are shooting so be sure to play weapon animations
		if canshoot and $BulletHealth.value > 0: #is true when the timer ends (can shoot and have bullets)
			$BulletHealth.value -= $BulletHealth.step
			get_node("../UI/BulletPlyr").update_bullet($BulletHealth.value)
			var b = Bullet.instance()
			Global.add_child(b)
			if Input.is_action_pressed("move_up") and not Input.is_action_pressed("crouch"):
				b.position = $Sprite/shootpointu.global_position
				b.rotation_degrees = -90 * sprite.scale.x
			elif Input.is_action_pressed("crouch") and not is_on_floor():
				b.position = $Sprite/shootpointj.global_position
				b.rotation_degrees = 90 * sprite.scale.x
				_velocity.y = -105
			elif Input.is_action_pressed("crouch"):
				b.position = $Sprite/shootpointd.global_position
				b.rotation_degrees = 90 * sprite.scale.x
			else:
				b.position = $Sprite/shootpointx.global_position
				b.rotation_degrees = 0
			canshoot = false
			timer.start() #cannot shoot until timer ends
			
		if $BulletHealth.value == 0 and get_node("../UI/reloadTimer").time_left == 0: #no bullets so reload
			get_node("../UI/BulletPlyr").update_bullet(-1)
			
	if direction.x !=0: #apply friction(1) and acceleration(.2)
		sprite.scale.x = 1 if direction.x > 0 else -1 #flip player if going left and vice versa
		_velocity.x = lerp(_velocity.x, direction.x * speed.x, .2)
	else:
		_velocity.x = lerp(_velocity.x, 0, 1)
		
	var animation = get_new_animation(is_shooting) #determines which animation to play

	if playeridle and animation == "stand":
		animation_player.play("idle")
	else:
		playeridle = false
		if idletimer.time_left > 0:
			idletimer.stop()
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

func get_new_animation(is_shooting):
	var animation_new = ""
	var crouch = Input.is_action_pressed("crouch") or Input.is_action_just_pressed("crouch") 
	var inputup = Input.is_action_pressed("move_up") or Input.is_action_just_pressed("move_up")

	if _velocity.y > 0: #airborne
		if !is_shooting: animation_new = "airborne" #airborne and not shooting
		else: #shooting
			if crouch: animation_new = "airborneshootdown"
			elif inputup: animation_new = "airborneshootup"
			else: animation_new = "airborneshoot"
	else: # not airborne
		if crouch:
			if is_shooting: animation_new = "crouchshoot"
			else: animation_new = "crouch"
		elif _velocity.x == 0: #not moving left or right
			if is_shooting: animation_new = "standshoot"
			else: 
				animation_new = "stand"
				if idletimer.time_left == 0 and playeridle == false:
					print("startingtimer")
					idletimer.start()
				
		elif inputup and is_shooting:
			if _velocity.x != 0: animation_new = "runshootup"
			else: animation_new = "standshootup"
		elif _velocity.x != 0:
			if is_shooting: animation_new = "runshoot"
			else: animation_new = "run"
		
	return animation_new

func _on_ProjectileTimer_timeout():
	canshoot = true

func playerdamage(damage,enemyPosition): #damage, blink, and knockback player
	knockback = true #player hit, enable knockback effect
	knocking = true

	enemyPos = enemyPosition
	if $TextureProgress.value <= 0: #if player is dead, end game DAMAGE
		print("i died")
	else: #decrease player health
		$TextureProgress.value -= damage
		get_node("../UI/HeartBarPlyr").update_health($TextureProgress.value)

func _on_BlinkTimer_timeout(): #while knockback enabled, blink enemy
	sprite.visible = true
	knocking = false
	blinktimer.stop()

func _on_IdleTimer_timeout():
	playeridle = true
