extends Area2D

onready var speed = 300
onready var plyrspeed = Global.get_node("plyrInst")._velocity.x
onready var plyrdir = Global.get_node("plyrInst/Sprite").scale.x

func _ready():
	visible = false
 
func _physics_process(delta):
	if (plyrdir == -1): #bullet position
		position -= transform.x * speed * delta
	else:
		position += transform.x * speed * delta
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("lvl") or body.is_in_group("enemy"): #when bullet enters level or enemy, free it
		queue_free()

	if body.is_in_group("enemy"): #if bullet enters enemy, update enemy health
		body.get_node("TextureProgress").value -= 10
		
		if body.get_node("TextureProgress").value <= 0: #if enemy health is 0, free it
			body.get_node("Hurtbox")._on_Timer_timeout()
			body.queue_free()
			var percent = randf()
			if percent > .5: #50% drop rate of heart regen
				var heart = load("res://src/Objects/heartpickup.tscn").instance()
				
				heart.position = body.position
				get_parent().call_deferred("add_child", heart)
				#get_tree().get_root().find_node("level", true, false).call_deferred("add_child","heart")
				
func _on_invisTimer_timeout():
	visible = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
