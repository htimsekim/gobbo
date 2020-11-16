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
			for _i in self.get_children():
				_i.hide()
			get_tree().paused = true
			Global.save_game(Global.game_name)
			get_node("../../BlackScreen/Timer").start()
			get_node("../../Sprite/AnimationPlayer").play("sleeping")
			get_node("../../BlackScreen/FadeOut").play("fade")

		else:
			queue_free()
			Global.player.canMove = true
		




