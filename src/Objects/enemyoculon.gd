class_name EnemyOcu
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2(1,0)
export var patrolDistance = 10 # walking distance of enemy
export var movespeed = 100 # walking distance of enemy
export var faceright = 1
var rgoal
var lgoal
var pos = Vector2()
var start_pos = self.position


	
	
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("hover")
	print(direction)
	if direction.x == 1:
		if self.position.x < start_pos.x + patrolDistance:
			self.position.x += movespeed
		else:
			direction.x = -1
	elif direction.x == -1:
		if self.position.x > start_pos.x - patrolDistance:
			self.position.x -= movespeed
		else:
			direction.x = 1
	
	
	
	if direction.x > 0: # Determine whether to flip enemy image to face player
		$Sprite.flip_h = false # Set Enemy facing right
	else:
		$Sprite.flip_h = true # Set Enemy facing left
		

		
	for i in get_slide_count(): #if player is colliding with enemy, 
		var collision = get_slide_collision(i)
		if "plyr" in collision.collider.name:
			print("damage")
			player.playerdamage($TextureProgress.step) #call enemydamage to damage, blink, and knockback player
			set_collision_mask(6) #colliding, so turn collision off
			$Timer.start() #turn collision on

func damage(amount): #called from projectile amount is 1
	if player.get_node("TextureProgress").value <= 0: #if enemy is dead, remove enemy
		print("i die")
	else: #decrease enemy health
		player.get_node("TextureProgress").value -= amount

func _on_Timer_timeout():
	set_collision_mask(7)
	player.knockback = false
	$Timer.stop()
