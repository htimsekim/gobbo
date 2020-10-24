extends Area2D

func _on_heartpickup_body_entered(body):
	if body.is_in_group("plyr"):	
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").value + Global.player.get_node("TextureProgress").step
		get_node("/root/Global/UI/HeartBarPlyr").update_health(Global.player.get_node("TextureProgress").value) #update ui w/ current health
		queue_free()
