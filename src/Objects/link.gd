extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn = "level/spawns/spawn"
export(String) var associated_trigger

func _on_ChangeStage_body_entered(body):
	if "plyrInst" in body.name:
		if associated_trigger == "":
			Global.goto_scene(target_stage, target_spawn)
		else:
			if not Global.get(associated_trigger)[0]:
				Global.goto_scene(target_stage.trim_suffix(".tscn")+Global.get(associated_trigger)[1]+".tscn", target_spawn)
			else:
				Global.goto_scene(target_stage.trim_suffix(".tscn")+Global.get(associated_trigger)[2]+".tscn", target_spawn)
