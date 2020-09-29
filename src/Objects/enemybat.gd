class_name EnemyBat
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2()
onready var distance = 0
onready var follow = false

func _physics_process(_delta): # Called every frame. _delta isn't used
	direction = player.position - position # get direction / distance of player

	if direction.x > 0: # Determine whether to flip enemy image to face player
		self.get_node("Sprite").set_flip_h(1) # Set Enemy facing right
	else:
		self.get_node("Sprite").set_flip_h(0) # Set Enemy facing left
	
	distance = sqrt(direction.x * direction.x + direction.y * direction.y) 	# calculate distance from player

	# If distance less than 150 and player isn't knocked already, then start Enemy following player
	if distance < 190 and player.knockback == false:
		follow = true

	if player.knockback == true: #player already knocked so don't follow
		follow = false
		
	if follow == true: #if following, move enemy
		move_and_slide(direction.normalized() * 100) #move enemy to player
		$AnimationPlayer.play("move")
		
		for i in get_slide_count(): #if player is colliding with enemy, 
			var collision = get_slide_collision(i)
			if "plyr" in collision.collider.name and player.knockback == false:
				player.playerdamage($TextureProgress.step, position) #call enemydamage to damage, blink, and knockback player
				set_collision_mask(6) #colliding, so turn collision off
				$Timer.start() #turn collision on
				print("Timer On")

func _on_Timer_timeout():
	set_collision_mask(7)
	player.knockback = false
	$Timer.stop()
	print("Timer Off")
