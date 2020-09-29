class_name Oculon
extends Character

onready var player = Global.get_node("plyrInst")
onready var direction = Vector2(1,0)
export(int) var patrolDistance # walking distance of enemy
export(int) var movespeed # walking distance of enemy
var start_pos

func _ready():
	start_pos = position.x
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	$AnimationPlayer.play("hover")

	if direction.x == 1:
		$Sprite.flip_h = false # Set Enemy facing right
		if position.x < start_pos + patrolDistance:
			var col := move_and_slide(Vector2(movespeed, 0))
		else:
			direction.x = -1
	elif direction.x == -1:
		$Sprite.flip_h = true # Set Enemy facing left
		if position.x > start_pos - patrolDistance:
			var col := move_and_slide(Vector2(-movespeed, 0))
		else:
			direction.x = 1
			
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

func _on_Area2D_area_entered(area):
	if area.name == "Hurtbox" and player.knockback == false:
		player.playerdamage($TextureProgress.step, position) #call enemydamage to damage, blink, and knockback player
		set_collision_mask(6) #colliding, so turn collision off
		$Timer.start() #turn collision on
