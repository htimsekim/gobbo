extends RigidBody2D
	
func _physics_process(delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("walk")
#	var collisionList = get_colliding_bodies()
#	if(get_colliding_bodies().size() > 0):
#		print(collisionList[0].get_name())
		
func damage(amount): #called from projectile amount is 1
	if $TextureProgress.value <= 0:
		self.queue_free()
	else:
		$TextureProgress.value -= amount


func _on_Enemy_body_entered(body):
	print("dfd")
