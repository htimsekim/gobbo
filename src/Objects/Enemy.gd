class_name Enemy
extends Character

signal health_updated(health)
signal killed()

export(float) var maxplyrhealth = 4
export(float) var health = maxplyrhealth 
onready var test = 0

func _physics_process(delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("walk")

	#var test = test_move(transform, speed * delta)
#	print(test)
	
func damage(amount): #called from projectile amount is 1
	health = health - amount
	_set_health(health, maxplyrhealth)	

