extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn

var doorIndicator = Global.get_node("plyrInst/Sprite/DoorIndicator")
var indicAnimation = Global.get_node("plyrInst/Sprite/DoorIndicator/AnimationPlayer")
var in_door = false

func _process(delta):
	if Input.is_action_pressed("move_up") and in_door:
		Global.goto_scene(target_stage, target_spawn)

func _on_Door_body_entered(body):
	if "plyrInst" in body.name:
		in_door = true
		indicAnimation.play("up")
		doorIndicator.visible = true

func _on_Door_body_exited(body):
	if "plyrInst" in body.name:
		in_door = false
		doorIndicator.visible = false
