extends Area2D

onready var speed = 200
onready var plyrspeed = Global.get_node("plyrInst")._velocity.x
onready var plyrdir = Global.get_node("plyrInst/Sprite").scale.x

func _physics_process(delta):
	if (plyrdir == -1): #moving same direction as facing
		position -= transform.x * speed * delta
	else:
		position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("lvl") or body.is_in_group("enemy"):
		queue_free()
	
	if body.is_in_group("enemy"):
		body.get_node("TextureProgress").value -= 10
		print(body.get_node("TextureProgress").value)
		if body.get_node("TextureProgress").value <= 0:
			body.queue_free()

