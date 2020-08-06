extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn

func _on_ChangeStage_body_entered(body):
	if "plyrInst" in body.name:
		Global.goto_scene(target_stage, target_spawn)
