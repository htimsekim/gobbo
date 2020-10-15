extends Area2D

func _on_bulletbox_body_entered(body):
	if body.is_in_group("plyr"):	
		Global.player.get_node("TextureProgress").max_value += 1 
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").max_value
		Global.player.updatehealth()
		queue_free()
