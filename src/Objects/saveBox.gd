extends Area2D

func _on_saveBox_body_entered(body):
	if body.is_in_group("plyr"):
		var confirm = load("res://src/UI/saveConfirm.tscn").instance()
		self.add_child(confirm)
		get_tree().paused = true
