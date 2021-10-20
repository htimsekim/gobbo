extends Control

var username
var dir
onready var conChoice = "newgame"

func _ready():	
	Global.path = "res://src/levels/gobtown-prequake.tscn"
	full_screen() #comment this code out to run the game in a window
	dir_contents("res://src/levels/")

func _process(_delta):
	if Input.is_action_just_pressed("move_up"):
		if conChoice == "newgame":
			get_node("Sprite").position = Vector2(186,700)
			conChoice = "quit"
			return
		if conChoice == "option":
			get_node("Sprite").position = Vector2(186,422)
			conChoice = "newgame"
			return
		if conChoice == "quit":
			get_node("Sprite").position = Vector2(186,560)
			conChoice = "option"
			return

	if Input.is_action_just_pressed("crouch"): 
		if conChoice == "newgame":
			get_node("Sprite").position = Vector2(186,560)
			conChoice = "option"
			return
		if conChoice == "option":
			get_node("Sprite").position = Vector2(186,700)
			conChoice = "quit"
			return
		if conChoice == "quit":
			get_node("Sprite").position = Vector2(186,422)
			conChoice = "newgame"
			return

	if Input.is_action_just_pressed("jump"): 
		if conChoice == "newgame":
			get_tree().change_scene("res://src/UI/titleStart.tscn")
		if conChoice == "option":
			print("option")
		if conChoice == "quit":
			get_tree().quit()
	
func full_screen():
#	if IP.get_local_addresses()[0]=="192.168.37.34":
#		OS.set_current_screen(2)
#	else:
#		OS.set_current_screen(0)
#	OS.window_fullscreen = true
#	OS.set_borderless_window(true)
	OS.set_current_screen(2)
	OS.window_fullscreen = true
	
func dir_contents(path): #creates box on main screen listing all levels for coding/testing
	dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				$ScrollContainer/ItemList.add_item(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
func _on_ItemList_item_activated(index):
	Global.load_player()
	Global.goto_scene("res://src/levels/" + $ScrollContainer/ItemList.get_item_text(index),"level/spawns/spawn1")
