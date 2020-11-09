extends Area2D
export var heartName = "" #tracks heartnames that are already picked up
var playerHealth = Global.player.get_node("TextureProgress")

func _ready():
	if Global.heart_boxes.has(heartName): #if heart is in array, remove it, it's one time use
		queue_free()

func _on_heartbox_body_entered(body):
	if body.is_in_group("plyr") and playerHealth.max_value < 10:	#if player on heart, and not maxed out
		playerHealth.max_value += 1 # increase max health
		playerHealth.value = playerHealth.max_value #set health to max
		Global.get_node("UI/HeartBarPlyr").update_maxhealth(playerHealth.max_value) #update ui w/ max health
		Global.get_node("UI/HeartBarPlyr").update_health(playerHealth.value) #update ui w/ current health
		Global.heart_boxes.append(heartName) #heart was taken, don't respawn again
		queue_free()
