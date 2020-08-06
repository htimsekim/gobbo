extends Node

const levelResource = "res://src/levels/goblintown.tscn"

func _ready():	
	full_screen() #comment this code out to run the game in a window
	Global.goto_scene(levelResource, "level/spawns/spawna")
	#print(get_viewport().size)
	
func full_screen():
	OS.set_current_screen(0)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
