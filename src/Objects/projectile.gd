extends Area2D

onready var speed = 200
onready var plyrspeed = Global.get_node("plyrInst")._velocity.x
onready var plyrdir = Global.get_node("plyrInst/Sprite").scale.x

func _physics_process(delta):
	if (plyrspeed > 0 and plyrdir == 1) or (plyrspeed < 0 and plyrdir == -1): #moving same direction as facing
		position += transform.x * (speed + abs(plyrspeed/2)) * delta #set bullet speed to half player speed
	else:
		position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("lvl") or body.is_in_group("enemy"):
		queue_free()
	
	if body.is_in_group("enemy"):
		body.damage(10)
