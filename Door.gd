extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn
export(String) var associated_trigger

var doorIndicator = Global.get_node("plyrInst/Sprite/DoorIndicator")
var indicAnimation = Global.get_node("plyrInst/Sprite/DoorIndicator/AnimationPlayer")
var in_door = false

func _process(_delta):
	if in_door and Global.player.is_on_floor():
		indicAnimation.play("up")
		doorIndicator.visible = true
		
	if Input.is_action_just_pressed("move_up") and in_door and Global.player.is_on_floor():
		if associated_trigger == "":
			Global.goto_scene(target_stage, target_spawn)
		else:
			if not Global.get(associated_trigger)[0]:
				Global.goto_scene(target_stage.trim_suffix(".tscn")+Global.get(associated_trigger)[1]+".tscn", target_spawn)
			else:
				Global.goto_scene(target_stage.trim_suffix(".tscn")+Global.get(associated_trigger)[2]+".tscn", target_spawn)

	

func _on_Door_body_entered(body):
	if "plyrInst" in body.name:
		in_door = true
		
	

func _on_Door_body_exited(body):
	if "plyrInst" in body.name:
		in_door = false
		doorIndicator.visible = false
