extends Button

func _on_newGameButton_toggled(_button_pressed):
	Global.load_player()
	Global.goto_scene("res://src/levels/gobtown-prequake.tscn","level/spawns/spawn1")
	
