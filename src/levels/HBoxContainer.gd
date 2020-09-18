extends HBoxContainer

var heart_full = preload("res://assets/art/ui/heart_full.png")
var heart_empty = preload("res://assets/art/ui/heart_empty.png")
var heart_half = preload("res://assets/art/ui/heart_half.png")

func update_health(value):
	for i in get_child_count():
		print(i)
		if value > i + 1 :
			get_child(i).texture = heart_full
		elif value > i:  
			get_child(i).texture = heart_half
		else:
			get_child(i).texture = heart_empty
