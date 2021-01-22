extends KinematicBody2D

var limitLeft
var limitRight
var direction = 1


func _ready():
	limitLeft = get_node("../level/Camera2D").camleft + 32
	limitRight = get_node("../level/Camera2D").camright - 32

func _physics_process(delta):
	if direction == 1 and position.x <= limitRight:
		position.x += direction
		if position.x >= limitRight:
			direction *= -1
	if direction == -1 and position.x >= limitLeft:
		position.x += direction
		if position.x <= limitLeft:
			direction *= -1
