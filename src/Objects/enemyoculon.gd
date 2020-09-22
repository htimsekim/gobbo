class_name EnemyOcu
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2()
export var patroldistance = 1.1 # walking distance of enemy
export var movespeed = 100 # walking distance of enemy
export var faceright = 1
var rgoal
var lgoal
var pos = Vector2()

func _ready():
	pos = Vector2(abs(position.x),0)
	lgoal = pos * patroldistance
	rgoal = pos/patroldistance
	print(rgoal)
	print(pos)
	print(lgoal)
func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("hover")
	direction = player.position - position # get direction / distance of player
	
	if direction.x > 0: # Determine whether to flip enemy image to face player
		$Sprite.flip_h = false # Set Enemy facing right
	else:
		$Sprite.flip_h = true # Set Enemy facing left
		
	pos = Vector2(abs(position.x),0)	
	if pos > rgoal:
		print(pos)
	#	var target = pos * patroldistance
		var velocity = rgoal.normalized() * movespeed
		velocity = move_and_slide(velocity)
	elif pos < lgoal:
		print("posh")
	#	var target = pos * patroldistance
		var velocity = lgoal.normalized() * movespeed
		velocity = move_and_slide(velocity)
		
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
