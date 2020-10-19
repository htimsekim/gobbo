class_name enemypatrol
extends Character

onready var direction = Vector2(1,0) #walking right or left
onready var platform_detector = $Hurtbox.get_node("FloorDetector") #raycast to detect floor
export(int) var patrolDistance # walking distance of enemy
var start_pos = 0

func _ready():
	start_pos = position.x
	
func _physics_process(delta): # Called every frame.
	var snap_vector = Vector2.DOWN
	_velocity.y += gravity * delta #set fall distance to ground
	
	var is_on_platform = platform_detector.is_colliding() #check if colliding with ground
	if is_on_platform == false: #if not on ground turn enemy
		direction.x *= -1
		
	if direction.x == 1: #flip character in right direction and patrol him
		$Sprite.flip_h = false # Set Enemy facing right
		if position.x < start_pos + patrolDistance: #if haven't reached patrolDis 
			_velocity.x = speed.x
			move_and_slide_with_snap(_velocity, snap_vector) #move toward it
		else: #reached patrolDis so flip enemy
			direction.x = -1
	elif direction.x == -1: #flip character in right direction and patrol him
		$Sprite.flip_h = true # Set Enemy facing left
		if position.x > start_pos - patrolDistance: #if haven't reached patrolDis 
			_velocity.x = -speed.x
			move_and_slide_with_snap(_velocity, snap_vector) #move toward it
		else: #reached patrolDis so flip enemy
			direction.x = 1
