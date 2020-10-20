extends CanvasLayer

onready var conChoice = ""
func _ready():
	get_node("NinePatchRect/Sprite").position = Vector2(20,51)
	
func _process(_delta):
	if Input.is_action_pressed("move_right"): 
		conChoice = "Yes"
		get_node("NinePatchRect/Sprite").position = Vector2(60,51)
	if Input.is_action_pressed("move_left"): 
		conChoice = "No"
		get_node("NinePatchRect/Sprite").position = Vector2(20,51)
	if Input.is_action_pressed("jump"): 
		if conChoice == "Yes":
			Global.save_game("GinaTest")
		get_tree().paused = false
		queue_free()

