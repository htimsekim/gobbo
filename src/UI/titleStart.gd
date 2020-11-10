extends Control

var dir
onready var conChoice = "GameAButton"

func _ready():
	dir_contents("user://")

func _process(_delta):
	if Input.is_action_just_pressed("move_up"):
		if conChoice == "SaveGameA":
			get_node("Sprite").position = Vector2(186,700)
			conChoice = "SaveGameC"
			return
		if conChoice == "SaveGameB":
			get_node("Sprite").position = Vector2(186,422)
			conChoice = "SaveGameA"
			return
		if conChoice == "SaveGameC":
			get_node("Sprite").position = Vector2(186,560)
			conChoice = "SaveGameB"
			return

	if Input.is_action_just_pressed("crouch"): 
		if conChoice == "SaveGameA":
			get_node("Sprite").position = Vector2(186,560)
			conChoice = "SaveGameB"
			return
		if conChoice == "SaveGameB":
			get_node("Sprite").position = Vector2(186,700)
			conChoice = "SaveGameC"
			return
		if conChoice == "SaveGameC":
			get_node("Sprite").position = Vector2(186,422)
			conChoice = "SaveGameA"
			return

	if Input.is_action_just_pressed("jump"): 
		Global.game_name = conChoice
		Global.load_game(conChoice)
		
func dir_contents(path): #creates box on main screen listing all levels for coding/testing
	dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name == "SaveGameA.bin":
					$menu/centerRow/buttons/GameAButton/Label.text = "1. " + file_name
				else:
					$menu/centerRow/buttons/GameAButton/Label.text = "1. <<EMPTY>>"
				if file_name == "SaveGameB.bin":
					$menu/centerRow/buttons/GameBButton/Label.text = "2. " + file_name
				else:
					$menu/centerRow/buttons/GameBButton/Label.text = "2. <<EMPTY>>"
				if file_name == "SaveGameC.bin":	
					$menu/centerRow/buttons/GameCButton/Label.text = "3. " + file_name
				else:
					$menu/centerRow/buttons/GameCButton/Label.text = "3. <<EMPTY>>"

			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
