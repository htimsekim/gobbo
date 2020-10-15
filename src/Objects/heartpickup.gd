extends Area2D

func _on_heartpickup_body_entered(_body):
	Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").value + Global.player.get_node("TextureProgress").step
	Global.player.updatehealth()
	queue_free()
