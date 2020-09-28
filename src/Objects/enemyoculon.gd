class_name Oculon
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2(1,0)
export(int) var patrolDistance # walking distance of enemy
export(int) var movespeed # walking distance of enemy
var start_pos
onready var posv = Vector2(0,0)

func _ready():
	start_pos = position.x
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("hover")

	if direction.x == 1:
		$Sprite.flip_h = false # Set Enemy facing right
		if position.x < start_pos + patrolDistance:
			position.x += movespeed
		else:
			direction.x = -1
	elif direction.x == -1:
		$Sprite.flip_h = true # Set Enemy facing left
		if position.x > start_pos - patrolDistance:
			position.x -= movespeed
		else:
			direction.x = 1

	var col = move_and_collide(posv)		
	if col: #if player is colliding with enemy, 
		if "plyr" in col.collider.name and player.knockback == false:
			player.playerdamage($TextureProgress.step, position) #call enemydamage to damage, blink, and knockback player
			set_collision_mask(6) #colliding, so turn collision off
			$Timer.start() #turn collision on
	
func damage(amount): #called from projectile amount is 1
	if player.get_node("TextureProgress").value <= 0: #if enemy is dead, remove enemy
		print("i died")
	else: #decrease enemy health
		player.get_node("TextureProgress").value -= amount

func _on_Timer_timeout():
	set_collision_mask(7)
	player.knockback = false
	$Timer.stop()
