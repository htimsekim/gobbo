extends Camera2D

# Called when the node enters the scene tree for the first time.
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

func _on_Camera2D_tree_exited():
	smoothing_enabled = false
#	yield(get_tree().create_timer(1.5), "timeout")
	#$Timer.start()
#	smoothing_enabled = true

func _on_Timer_timeout():
	smoothing_enabled = true
