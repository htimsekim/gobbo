extends Node
const playerResource = preload("res://src/Objects/Player.tscn")
var current_scene = null

func _ready():	
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1) # get current scene to remove/update

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

	var camera = get_node("plyrInst/Camera2D")
	var map_limits = Global.current_scene.get_node("level/tilemaps/limits").get_used_rect()
	var map_cellsize = Global.current_scene.get_node("level/tilemaps/limits").cell_size
	
	camera.limit_left = map_limits.position.x * map_cellsize.x
	camera.limit_right = map_limits.end.x * map_cellsize.x
	camera.limit_top = map_limits.position.y * map_cellsize.y
	camera.limit_bottom = map_limits.end.y * map_cellsize.y
	
	#print("camera.limit_left = ", camera.limit_left)
	#print("camera.limit_right = ", camera.limit_right)
	#print("camera.limit_top = ", camera.limit_top)
	#print("camera.limit_bottom = ", camera.limit_bottom)
	
	if(camera.limit_right - camera.limit_left) > 384 and (camera.limit_bottom - camera.limit_top) > 224:
		pass
		
	camera.current = true
	
	
