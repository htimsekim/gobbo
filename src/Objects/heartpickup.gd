extends Area2D

func _physics_process(_delta): # Called every frame. _delta isn't used
	if $pickupTimer.time_left == 0: #if timer not started, start so heart will disappear after x seconds
		$pickupTimer.start()
	
func _on_heartpickup_body_entered(body):
	if body.is_in_group("plyr"):	
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").value + Global.player.get_node("TextureProgress").step
		get_node("/root/Global/UI/HeartBarPlyr").update_health(Global.player.get_node("TextureProgress").value) #update ui w/ current health
		queue_free()

func _on_pickupTimer_timeout():
	queue_free() #free heart since it hasn't been picked up
