extends Area2D
export var heartName = "" #tracks heartnames that are already picked up

func _ready():
	if Global.heart_boxes.has(heartName): #if heart is in array, remove it, it's one time use
		queue_free()

func _on_heartbox_body_entered(body):
	if body.is_in_group("plyr") and Global.player.get_node("TextureProgress").max_value < 10:	#if player on heart, and not maxed out
		Global.player.get_node("TextureProgress").max_value += 1 # increase max health
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").max_value #set health to max
		Global.get_node("UI/HeartBarPlyr").update_maxhealth(Global.player.get_node("TextureProgress").max_value) #update ui w/ max health
		Global.get_node("UI/HeartBarPlyr").update_health(Global.player.get_node("TextureProgress").value) #update ui w/ current health
		Global.heart_boxes.append(heartName) #heart was taken, don't respawn again
		queue_free()
