extends Node

const levelResource = "res://src/levels/demo.tscn"

func _ready():	
	#OS.window_fullscreen = true
	Global.goto_scene(levelResource, "spawns/spawna")
