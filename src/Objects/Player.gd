class_name Player
extends Character

const FLOOR_DETECT_DISTANCE = 8.0 # < sprite height so player doesn't drop so fast from one block
onready var platform_detector = $PlatformDetector
onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var SpriteGunV = get_node("Gun/SpriteGun") 
onready var canshoot = false
onready var timer = $ProjectileTimer

func _physics_process(_delta): # Called every frame. _delta isn't used
	var direction = get_direction() #function determines if player is moving right or left
	var is_jump_interrupted = Input.is_action_just_released("jump") and _velocity.y < 0.0
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap_vector = Vector2.DOWN * FLOOR_DETECT_DISTANCE if direction.y == 0.0 else Vector2.ZERO
	var is_on_platform = platform_detector.is_colliding()
	_velocity = move_and_slide_with_snap(_velocity, snap_vector, FLOOR_NORMAL, not is_on_platform, 4, 0.9, false)
	var is_shooting = false #to determine if gun needs to be out and which animation to play

	if Input.is_action_pressed("shoot") or Input.is_action_pressed("stab"):
		gundirection() #set direction of weapon to mouse pointer
		is_shooting = true #we are shooting so be sure to play weapon animations
		if Input.is_action_pressed("stab"):
			get_node("Gun/AnimationPlayerGun").play("stab")
		if Input.is_action_pressed("shoot"):
			if canshoot: #is true when the timer ends
				$Gun.shoot()
				canshoot = false
				timer.start() #cannot shoot until timer ends
			get_node("Gun/AnimationPlayerGun").play("shoot")
	else: #we are not shooting so don't show weapon and set player direction to running direction
		SpriteGunV.visible = false
		if direction.x != 0: #flip player if going left and vice versa
			sprite.scale.x = 1 if direction.x > 0 else -1

#	if Input.is_action_just_pressed("jump"):
#		animation_player.play("crouch")	
	var targetpos = 80
	var targetinc = .05

	if direction.x !=0: #apply friction(1) and acceleration(.2)
		_velocity.x = lerp(_velocity.x, direction.x * speed.x, .2)
#		if(position.x > $Camera2D.limit_right - 80):
		$Camera2D.offset.x = lerp($Camera2D.offset.x, direction.x * targetpos, targetinc)
		#print("$Camera2D.offset.x = ", $Camera2D.offset.x, " direction.x * targetpos = ", direction.x * targetpos, " direction.x * targetinc = ", targetinc)
	else:
		_velocity.x = lerp(_velocity.x, 0, 1)
		$Camera2D.offset.x = lerp($Camera2D.offset.x ,0, targetinc)
		
	var animation = get_new_animation(is_shooting) #determines which animation to play

	if animation != animation_player.current_animation:
		animation_player.play(animation)
		
func get_direction(): #determine if player is moving right or left
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), -1 if is_on_floor() and Input.is_action_just_pressed("jump") else 0)
	
# Calculates new velocity. It allows you to interrupt jumps.
func calculate_move_velocity(linear_velocity, direction, speed, is_jump_interrupted ):
	var velocity = linear_velocity

	if direction.y != 0.0: velocity.y = speed.y * direction.y
	if is_jump_interrupted: velocity.y = 0.0

	if linear_velocity.y < 15.5: #jump buffer between 15.5 and 15
		if Input.is_action_just_released("jump") or Input.is_action_just_pressed("jump"): 	
			velocity.y = speed.y * direction.y
			
	#fall through one way collision items
	if Input.is_action_pressed("jump") and Input.is_action_pressed("crouch") and is_on_floor(): 
		velocity.y = 0.0
		self.position = Vector2(self.position.x, self.position.y + 2)
		
	return velocity

func get_new_animation(is_shooting = false):
	var animation_new = ""
			
	if is_on_floor():
		animation_new = "run" if abs(_velocity.x) > 0.1 else "idle"
	else:
		animation_new = "airborne"

	if Input.is_action_pressed("crouch") and _velocity.y == 0.0: #only crouch while idle
		if abs(_velocity.x) < 0.1: animation_new = "crouch"

	if is_shooting: #add weapon animation to existing animation. ex run_armless
		animation_new += "_armless"
	return animation_new

func gundirection(): #point gun in direction of mouse pointer and the character in direction of gun
	SpriteGunV.visible = true

	$Gun.rotation = get_local_mouse_position().angle()
	var facerightleft = $Gun.rotation #face player and gun right
	if $Gun.rotation < 0:  #if gun if facing left, get rid of negative values for following range check
		facerightleft = $Gun.rotation * -1
		
	if facerightleft > 0 and facerightleft <= 1.7: #facing right
		sprite.scale.x = 1
		$Gun.position.x = 3.622
		$Gun.scale.y = 1
		return
	elif facerightleft > 1.3: #facing left
		sprite.scale.x = -1
		$Gun.position.x = -3.622
		$Gun.scale.y = -1

func _on_ProjectileTimer_timeout():
	canshoot = true

func _on_Hitbox_area_entered(area):
	if sprite.scale.x == 1:
		_velocity.x -= 500
	if sprite.scale.x == -1:
		_velocity.x += 500
	_velocity.y -= 100

	move_and_slide(_velocity)
	
	$TextureProgress.value -= area.get_node("../TextureProgress").step
	if $TextureProgress.value <= 0:
		get_tree().quit()
