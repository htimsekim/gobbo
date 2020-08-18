extends Node

const levelResource = "res://src/levels/forest.tscn"
#const levelResource = "res://src/levels/gobtown.tscn"

func _ready():	
	full_screen() #comment this code out to run the game in a window
	Global.goto_scene(levelResource, "level/spawns/spawna")

func full_screen():
	OS.set_current_screen(0)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
