extends Area2D
export var heartName = "" #tracks heartnames that are already picked up
var playermaxhealth = Global.player.get_node("TextureProgress").max_value
var playercurhealth = Global.player.get_node("TextureProgress").value

func _on_bulletbox_body_entered(body):
	if body.is_in_group("plyr") and Global.player.get_node("BulletHealth").max_value < 10:
		Global.player.get_node("BulletHealth").max_value += 1 
		Global.player.get_node("BulletHealth").value = Global.player.get_node("BulletHealth").max_value
		Global.get_node("UI/BulletPlyr").update_maxbullet(Global.player.get_node("BulletHealth").max_value)
		queue_free()
