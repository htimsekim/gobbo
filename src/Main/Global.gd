extends Node
const playerResource = preload("res://src/Objects/Player.tscn")
const cameraResource = preload("res://src/Objects/camera.tscn")
var current_scene = null
var map_limits = 0
var camera

func _ready():	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1) # get current scene to remove/update

	var cameraInstance = cameraResource.instance() #instance in camera
	cameraInstance.set_name("camInst")
	self.add_child(cameraInstance)
	camera = get_node("camInst")
	
	var playerInstance = playerResource.instance() #instance in player 
	playerInstance.set_name("plyrInst")
	self.add_child(playerInstance)
		
func goto_scene(path, spawn): #main scene switcher call - Global.goto_scene("res://Scene2.tscn")
	call_deferred("_deferred_goto_scene", path, spawn)
	get_tree().call_group("projectile","queue_free")
	
func _deferred_goto_scene(path, spawn: String):
	current_scene.free() # It is now safe to remove the current scene
	var s = ResourceLoader.load(path) # Load the new scene.
	current_scene = s.instance() # Instance the new scene.
	get_tree().get_root().add_child(current_scene) # Add it to the active scene, as child of root.
	#Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	
	get_node("plyrInst").position = current_scene.get_node(str(spawn)).position #set plyr spawn
	
	map_limits = current_scene.get_node("level/tilemaps/limits").get_used_cells()
	var map_cellsize = current_scene.get_node("level/tilemaps/limits").cell_size
	
	
	
	
	camera.limit_left = map_limits[0].x * map_cellsize.x 
	camera.limit_right = map_limits.back().x * map_cellsize.x 
	camera.limit_top = map_limits[0].y * map_cellsize.y 
	camera.limit_bottom = map_limits.back().y * map_cellsize.y 
	
	var camtop = camera.limit_top
	var cambot = camera.limit_bottom
	var camleft = camera.limit_left
	var camright = camera.limit_right
	
	if abs(camtop - cambot) <= 224:
		camera.limit_bottom = ((camtop + cambot)/2) + 108
		camera.limit_top = ((camtop + cambot)/2) - 108

	if abs(camleft - camright) <= 384:
		camera.limit_right = ((camleft + camright)/2 + 192)
		camera.limit_left = ((camleft + camright)/2 - 192)

	camera.current = true
