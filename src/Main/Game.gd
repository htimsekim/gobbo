extends Node

const levelResource = "res://src/levels/treetops.tscn"
#const levelResource = "res://src/levels/gobtown-prequake.tscn"
#const levelResource = "res://src/levels/gobtown-prequake.tscn"

var username


func _ready():	
	full_screen() #comment this code out to run the game in a window
	Global.goto_scene(levelResource, "level/spawns/spawn1")

func full_screen():

	if IP.get_local_addresses()[0]=="192.168.37.34":
		OS.set_current_screen(2)
	else:
		OS.set_current_screen(0)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
