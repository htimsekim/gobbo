extends KinematicBody2D

var move = Vector2(0,0)
var rotating: int
var speed = 50
onready var player = Global.get_node("plyrInst")

func _physics_process(delta):
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return
	
	var col := move_and_collide(move * speed * delta)

	if col:
		if "plyr" in col.collider.name:
			if player.knockback == false: 
				player.playerdamage($TextureProgress.step, position) #call enemydamage to damage, blink, and knockback player
				set_collision_mask(6) #colliding, so turn collision off
				$Timer.start() #turn collision on
				print("Timer On")
			return
		
	if col and col.normal.rotated(PI/2).dot(move) < 0.5:
		rotating = 4
		move = col.normal.rotated(PI/2)
		return
	
	var pos := position
	col = move_and_collide(move.rotated(PI/2) * 3.4)
	if not col:
		for i in 10:
			position = pos
			rotate(PI/32)
			move = move.rotated(PI/32)
			col = move_and_collide(move.rotated(PI/2) * 3.4)
			
			if col:
				move = col.normal.rotated(PI/2)
				rotation = move.angle()
				break
	else:
		move = col.normal.rotated(PI/2)
		rotation = move.angle()

func _on_Timer_timeout():
	set_collision_mask(7)
	player.knockback = false
	$Timer.stop()
	print("Timer Off")
