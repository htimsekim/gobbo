class_name SkelemanWalker
extends Character

onready var direction = Vector2(1,0)
export(int) var patrolDistance # walking distance of enemy
export(int) var movespeed # walking distance of enemy
var start_pos

func _ready():
	start_pos = position.x
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("walk")

	if direction.x == 1:
#		print(position.x)
#		print(start_pos)
#		print(patrolDistance)
		$Sprite.flip_h = false # Set Enemy facing right
		if position.x < start_pos + patrolDistance:
			move_and_slide(Vector2(movespeed, 0))
		else:
			direction.x = -1
	elif direction.x == -1:
		$Sprite.flip_h = true # Set Enemy facing left
		if position.x > start_pos - patrolDistance:
			move_and_slide(Vector2(-movespeed, 0))
		else:
			direction.x = 1
