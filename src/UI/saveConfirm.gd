extends CanvasLayer

onready var conChoice = ""
func _ready():
	get_node("Sprite").position = Vector2(160,406)
	
func _process(_delta):
	if Input.is_action_pressed("move_right"): 
		conChoice = "Yes"
		get_node("Sprite").position = Vector2(485,406)
	if Input.is_action_pressed("move_left"): 
		conChoice = "No"
		get_node("Sprite").position = Vector2(160,406)
	if Input.is_action_pressed("jump"): 
		if conChoice == "Yes":
			Global.save_game("GinaTest")
		get_tree().paused = false
		queue_free()

