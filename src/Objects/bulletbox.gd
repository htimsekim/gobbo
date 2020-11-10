extends Area2D
export var bulletName = "" #tracks bulletnames that are already picked up
var bullethealth = Global.player.get_node("BulletHealth")

func _ready():
	if Global.bullet_boxes.has(bulletName): #if bullet is in array, remove it, it's one time use
		queue_free()
	
func _on_bulletbox_body_entered(body):
	if body.is_in_group("plyr") and bullethealth.max_value < 10:
		bullethealth.max_value += 1 
		bullethealth.value = bullethealth.max_value
		Global.get_node("UI/BulletPlyr").update_maxbullet(bullethealth.max_value)
		Global.bullet_boxes.append(bulletName) #bullet was taken, don't respawn again
		queue_free()
