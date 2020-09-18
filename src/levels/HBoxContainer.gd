extends HBoxContainer

#enum MODES {simple, empty, partial}

var heart_full = preload("res://assets/art/ui/heart.png")
var heart_empty = preload("res://assets/art/ui/heart.png")
var heart_half = preload("res://assets/art/ui/heart.png")

#export (MODES) var mode = MODES.partial

func update_health(value):
	print("ee")
	for i in get_child_count():
		if value > i * 2 + 1:
			get_child(i).texture = heart_full
		elif value > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
			
func update_partial(value):
	for i in get_child_count():
		if value > i * 2 + 1:
			get_child(i).texture = heart_full
		elif value > i * 2:
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
