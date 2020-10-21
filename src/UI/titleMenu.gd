extends Control

var username
var dir
func _ready():	
	Global.path = "res://src/levels/gobtown-prequake.tscn"
	full_screen() #comment this code out to run the game in a window
	dir_contents("res://src/levels/")
	
func full_screen():
	if IP.get_local_addresses()[0]=="192.168.37.34":
		OS.set_current_screen(2)
	else:
		OS.set_current_screen(0)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
	
func dir_contents(path):
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
	


