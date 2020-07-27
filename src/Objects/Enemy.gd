class_name Enemy
extends Character

func _physics_process(delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("walk")
	
func damage(amount): #called from projectile amount is 1
	if $TextureProgress.value <= 0:
		self.queue_free()
	else:
		$TextureProgress.value -= amount
