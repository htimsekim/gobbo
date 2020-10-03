class_name Crawler
extends Character

var move = Vector2(0,0)
var rotating: int

func _physics_process(delta):
	speed = 50
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return
	
	var col := move_and_collide(move * speed * delta)

	if col and col.normal.rotated(PI/2).dot(move) < 0.5: #if hit a corner, turn after rotating 6
		rotating = 5
		move = col.normal.rotated(PI/2)
		return
	
	var pos := position
	col = move_and_collide(move.rotated(PI/2) * 3.4)
	if not col:
#		for i in 10:
#			position = pos
#			rotate(PI/32)
#			move = move.rotated(PI/32)
#			col = move_and_collide(move.rotated(PI/2) * 3.4)
		rotating = 6
		rotate(PI/32)
		move = move.rotated(PI/32)
#		move = col.normal.rotated(PI/2)
		return
			
#			if col:
#				move = col.normal.rotated(PI/2)
#				rotation = move.angle()
#				break
	if col: #colliding so move in direction of rotation
		move = col.normal.rotated(PI/2)
		rotation = move.angle()
