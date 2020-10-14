class_name enemypatrol
extends KinematicBody2D

onready var direction = Vector2(1,0)
export(int) var patrolDistance # walking distance of enemy
export(int) var movespeed # walking distance of enemy
var start_pos = 0

func _ready():
	start_pos = position.x
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	if direction.x == 1: #flip character in right direction and patrol him
		$Sprite.flip_h = false # Set Enemy facing right
		if position.x < start_pos + patrolDistance:
			move_and_slide(Vector2(movespeed, 0))
		else:
			direction.x = -1
	elif direction.x == -1:
		$Sprite.flip_h = true # Set Enemy facing left
		if position.x > start_pos - patrolDistance:
			move_and_slide(Vector2(movespeed, 0))
		else:
			direction.x = 1