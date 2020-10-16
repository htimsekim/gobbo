extends Area2D

func _on_heartpickup_body_entered(body):
	if body.is_in_group("plyr"):	
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").value + Global.player.get_node("TextureProgress").step
		Global.player.updatehealth()
		queue_free()
