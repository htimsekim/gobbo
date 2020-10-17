extends Area2D

func _on_bulletbox_body_entered(body):
	if body.is_in_group("plyr") and Global.player.get_node("BulletHealth").max_value < 10:
		Global.player.get_node("BulletHealth").max_value += 1 
		Global.player.get_node("BulletHealth").value = Global.player.get_node("BulletHealth").max_value
		get_tree().get_root().get_node("Global/UI/BulletPlyr").update_maxbullet(Global.player.get_node("BulletHealth").max_value)
		queue_free()
