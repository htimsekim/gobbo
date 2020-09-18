extends Area2D

export(String, FILE, "*.tscn") var target_stage
export(String) var target_spawn

var doorIndicator = Global.get_node("plyrInst/Sprite/DoorIndicator")
var indicAnimation = Global.get_node("plyrInst/Sprite/DoorIndicator/AnimationPlayer")
var in_door = false

func _process(_delta):
	if in_door and Global.player.is_on_floor():
		indicAnimation.play("up")
		doorIndicator.visible = true
		
	if Input.is_action_just_pressed("move_up") and in_door and Global.player.is_on_floor():
		Global.goto_scene(target_stage, target_spawn)
	

func _on_Door_body_entered(body):
	if "plyrInst" in body.name:
		in_door = true
		
	

func _on_Door_body_exited(body):
	if "plyrInst" in body.name:
		in_door = false
		doorIndicator.visible = false
