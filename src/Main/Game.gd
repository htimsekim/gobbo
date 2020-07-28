extends Node

const levelResource = "res://src/levels/gobtown.tscn"

func _ready():	
	#OS.window_fullscreen = true
	Global.goto_scene(levelResource, "level/spawns/spawna")
