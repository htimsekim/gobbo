extends Node

const levelResource = "res://src/levels/demo.tscn"
#const levelResource = "res://src/levels/gobtown-prequake.tscn"

var username


func _ready():	
	if OS.has_environment("USERNAME"):
		username = OS.get_environment("USERNAME")
	else:
		username = "player"
	
	full_screen() #comment this code out to run the game in a window
	Global.goto_scene(levelResource, "level/spawns/spawn1")

func full_screen():
	if username == "mike":
		OS.set_current_screen(0)
	else:
		OS.set_current_screen(2)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
