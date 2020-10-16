extends Area2D

func _on_saveBox_body_entered(body):
	var confirm = load("res://src/UI/saveConfirm.tscn").instance()
	self.add_child(confirm)
	get_tree().paused = true
