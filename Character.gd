class_name Character
extends KinematicBody2D

# layer, Enemy inherit scene
export var speed = Vector2(150.0, 350.0)
onready var gravity = ProjectSettings.get("physics/2d/default_gravity")
const FLOOR_NORMAL = Vector2.UP
var _velocity = Vector2.ZERO

# _physics_process is called after the inherited _physics_process function.
# This allows the Player and Enemy scenes to be affected by gravity.
func _physics_process(delta):
	_velocity.y += gravity * delta

#func damage(amount):
	#_set_health(health - amount)	
	#damagetaken = true	
	
func kill():
	print("playerdead")
	
func _set_health(value, maxplyrhealth):
	print("this work")
	var health = clamp(value, 0, maxplyrhealth)
	print(health)
	emit_signal("health_updated", health)	
	if health == 0:
		kill()
		emit_signal("killed")
