extends Node

const levelResource = "res://src/levels/demo.tscn"
#const levelResource = "res://src/levels/gobtown-prequake.tscn"

var username


func _ready():	
	full_screen() #comment this code out to run the game in a window
	Global.goto_scene(levelResource, "level/spawns/spawn1")

func full_screen():
	if IP.get_local_addresses()[4]=="192.168.37.3":
		OS.set_current_screen(0)
	else:
		OS.set_current_screen(2)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
