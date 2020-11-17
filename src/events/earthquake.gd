extends Area2D

func _on_Area2D_body_entered(_body):
	if not Global.earthquake_happened[0]:
		print("earthquake")
		Global.earthquake_happened[0] = true
		get_node("../../../Camera2D").earthquake()
		$QuakeTimer.start()
		Global.player.canMove = false


func _on_QuakeTimer_timeout():
	Global.player.canMove = true
