class_name Character
extends KinematicBody2D

# Player, Enemy inherit scene
export var speed = Vector2(150.0, 350.0)
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
const FLOOR_NORMAL = Vector2.UP
var _velocity = Vector2.ZERO

# _physics_process is called after the inherited _physics_process function.
func _physics_process(delta):
	_velocity.y += gravity * delta
