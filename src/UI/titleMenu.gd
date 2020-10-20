extends Control

var username

func _ready():	
	full_screen() #comment this code out to run the game in a window

func full_screen():
	if IP.get_local_addresses()[0]=="192.168.37.34":
		OS.set_current_screen(2)
	else:
		OS.set_current_screen(0)
	OS.window_fullscreen = true
	OS.set_borderless_window(true)
