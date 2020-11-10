extends CanvasLayer

onready var conChoice = ""

func _ready():
	get_node("Sprite").position = Vector2(441,330)
	conChoice = "No"
	
func _process(_delta):
	if Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"): 
		if conChoice == "No":
			get_node("Sprite").position = Vector2(183,330)
			conChoice = "Yes"
		else:
			get_node("Sprite").position = Vector2(441,330)
			conChoice = "No"
	
	if Input.is_action_just_pressed("jump"): 
		if conChoice == "Yes":
			Global.save_game(Global.game_name)
		get_tree().paused = false
		queue_free()
