extends Area2D

func _on_saveBox_body_entered(body):
	if body.is_in_group("plyr"):
		var confirm = load("res://src/UI/saveConfirm.tscn").instance()
		self.add_child(confirm)
		$Sprite/AnimationPlayer.play("sleeping")
		Global.player.canMove = false


func _on_saveBox_body_exited(body):
	if body.is_in_group("plyr"):
		$Sprite/AnimationPlayer.play("idle")
