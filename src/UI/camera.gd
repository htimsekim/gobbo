extends Camera2D

var camtop
var cambot
var camleft
var camright

func _ready():
	var map_limits = get_node("../tilemaps/limits").get_used_cells()
	var map_cellsize = get_node("../tilemaps/limits").cell_size
	
	limit_left = map_limits[0].x * map_cellsize.x 
	limit_right = map_limits.back().x * map_cellsize.x 
	limit_top = map_limits[0].y * map_cellsize.y 
	limit_bottom = map_limits.back().y * map_cellsize.y 
	
	camtop = limit_top
	cambot = limit_bottom
	camleft = limit_left
	camright = limit_right
	
	#please leave these
	print(map_limits)
	print("map ", max(24,abs(camleft-camright)/16), " x ", max(14,(abs(camtop-cambot)+16)/16))
	
	if abs(camtop - cambot) <= 224:
		limit_bottom = ((camtop + cambot)/2) + 112
		limit_top = ((camtop + cambot)/2) - 104

	if abs(camleft - camright) <= 384:
		limit_right = ((camleft + camright)/2 + 192)
		limit_left = ((camleft + camright)/2 - 192)
	
func _physics_process(_delta): # Called every frame. _delta isn't used
	position = get_tree().get_root().get_node("Global/plyrInst").position

func earthquake() -> void:
	$ScreenShake.start(3, 15, 8, 0)
