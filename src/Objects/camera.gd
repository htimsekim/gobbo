extends Camera2D

func _ready():
	var map_limits = get_node("../tilemaps/limits").get_used_cells()
	var map_cellsize = get_node("../tilemaps/limits").cell_size
	
	limit_left = map_limits[0].x * map_cellsize.x 
	limit_right = map_limits.back().x * map_cellsize.x 
	limit_top = map_limits[0].y * map_cellsize.y 
	limit_bottom = map_limits.back().y * map_cellsize.y 
	
	var camtop = limit_top
	var cambot = limit_bottom
	var camleft = limit_left
	var camright = limit_right
	
	if abs(camtop - cambot) <= 224:
		limit_bottom = ((camtop + cambot)/2) + 108
		limit_top = ((camtop + cambot)/2) - 108

	if abs(camleft - camright) <= 384:
		limit_right = ((camleft + camright)/2 + 192)
		limit_left = ((camleft + camright)/2 - 192)
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	position = get_node("../../../Global/plyrInst").position
	#adjusts camera smoothing based on player speed (prevents player falling offscreen etc)
	var activespeed = abs(max(Global.player._velocity.x, Global.player._velocity.y))
	if activespeed !=0:
		smoothing_speed = activespeed/200
	else:
		smoothing_speed = .75
	
	var targetinc = 1
	if Global.player.direction.x !=0: 
		offset_h = Global.player.direction.x * targetinc
	else:
		offset_h = 0

func _on_Camera2D_tree_exited():
	smoothing_enabled = false

func _on_Timer_timeout():
	smoothing_enabled = true
