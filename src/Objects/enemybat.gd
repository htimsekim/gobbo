class_name Enemy
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2()
onready var distance = 0
onready var follow = false

func _physics_process(delta): # Called every frame. _delta isn't used
	direction = player.position - position # get direction / distance of player
	# Determine whether to flip enemy image to face player
	if direction.x > 0:
		self.get_node("Sprite").set_flip_h(1) # Set Enemy facing right
	else:
		self.get_node("Sprite").set_flip_h(0) # Set Enemy facing left
	
	distance = sqrt(direction.x * direction.x + direction.y * direction.y) 	# calculate distance from player

	# If distance less than 150 then start Enemy following player
	if distance < 190 and player.knockback == false:
		follow = true
	if player.knockback == true:
		follow = false
		
	if follow == true:
		move_and_slide(direction.normalized() * 100) #move enemy to player
		$AnimationPlayer.play("move")
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			#print("I collided with ", collision.collider.name)
			if "plyr" in collision.collider.name:
				damage(10)
				set_collision_mask(6)
				$Timer.start()
				
		
func damage(amount): #called from projectile amount is 1
	if player.get_node("TextureProgress").value <= 0: #if enemy is dead, remove enemy
		print("i die")
	else: #decrease enemy health
		print("ouch")
		player.get_node("TextureProgress").value -= amount
		



func _on_Timer_timeout():
	set_collision_mask(7)
