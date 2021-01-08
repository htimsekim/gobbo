extends Area2D

func _on_saveBox_body_entered(body):
	if body.is_in_group("plyr"):
		var confirm = load("res://src/UI/saveConfirm.tscn").instance()
		self.add_child(confirm)
		Global.player.shootAllowed = false
		Global.player.canMove = false


func _on_saveBox_body_exited(body):
	if body.is_in_group("plyr"):
		$Sprite/AnimationPlayer.play("idle")
		Global.player.shootAllowed = true


func _on_Timer_timeout():
	print("times up")
	get_node("Sprite/AnimationPlayer").play("idle")
	Global.player.canMove = true
	get_node("Node2D").queue_free()
	get_tree().paused = false
