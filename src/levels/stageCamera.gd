extends Camera2D
#maybe delete this soon
func _ready():
	set_camera_limits()


func set_camera_limits():
	var map_limits = get_node("../tilemaps/collision").get_used_rect()
	var map_cellsize = get_node("../tilemaps/collision").cell_size
	self.limit_left = map_limits.position.x * map_cellsize.x
	self.limit_right = map_limits.end.x * map_cellsize.x
	self.limit_top = map_limits.position.y * map_cellsize.y
	self.limit_bottom = map_limits.end.y * map_cellsize.y
