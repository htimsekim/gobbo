extends Button

func _on_newGameButton_toggled(_button_pressed):
	Global.load_player()
	Global.goto_scene(Global.path,"level/spawns/spawn1")
