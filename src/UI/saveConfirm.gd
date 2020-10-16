extends CanvasLayer

onready var conChoice = ""

func _process(_delta):
	if Input.is_action_pressed("move_left"): 
		conChoice = "Yes"
		get_node("NinePatchRect/VBoxContainer/HBoxContainer/Sprite").position = Vector2(105,70)
	if Input.is_action_pressed("move_right"): 
		conChoice = "No"
		get_node("NinePatchRect/VBoxContainer/HBoxContainer/Sprite").position = Vector2(410,70)
	if Input.is_action_pressed("jump"): 
		if conChoice == "Yes":
			print("saving")
		get_tree().paused = false
		queue_free()

