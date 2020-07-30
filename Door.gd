extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn

var in_door = false

func _process(delta):
	if Input.is_action_pressed("move_up") and in_door:
		Global.goto_scene(target_stage, target_spawn)
		get_tree().call_group("projectile","queue_free")
		print("trying")

func _on_Door_body_entered(body):
	if "plyrInst" in body.name:
		in_door = true
		print("in")




func _on_Door_body_exited(body):
	if "plyrInst" in body.name:
		in_door = false
		print("out")
