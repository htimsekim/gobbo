extends Area2D
export var heartName = "" #tracks heartnames that are already picked up
var playermaxhealth = Global.player.get_node("TextureProgress").max_value
var playercurhealth = Global.player.get_node("TextureProgress").value

func _ready():
	if Global.heart_boxes.has(heartName): #if heart is in array, remove it, it's one time use
		queue_free()

func _on_heartbox_body_entered(body):
	if body.is_in_group("plyr") and playermaxhealth < 10:	#if player on heart, and not maxed out
		playermaxhealth += 1 # increase max health
		playercurhealth = playermaxhealth #set health to max
		Global.get_node("UI/HeartBarPlyr").update_maxhealth(playermaxhealth) #update ui w/ max health
		Global.get_node("UI/HeartBarPlyr").update_health(playercurhealth) #update ui w/ current health
		Global.heart_boxes.append(heartName) #heart was taken, don't respawn again
		queue_free()
