extends RigidBody2D

func _physics_process(delta):
	pass
	






func _on_RigidBody2D_body_entered(body):
	print(get_colliding_bodies())
