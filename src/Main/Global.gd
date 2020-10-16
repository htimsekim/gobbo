extends Node
const playerResource = preload("res://src/Objects/Player.tscn")
const UIResource = preload("res://src/levels/ui.tscn")
var current_scene = null
var camera
var player
var ui
var earthquake_happened = [false, "-prequake", "-postquake"]

func load_player():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1) # get current scene to remove/update
	var playerInstance = playerResource.instance() #instance in player 
	playerInstance.set_name("plyrInst")
	self.add_child(playerInstance)
	player = get_node("plyrInst")
	var UIInstance = UIResource.instance() #instance in player 
	self.add_child(UIInstance)
	get_node("UI/HeartBarPlyr").update_maxhealth(get_node("plyrInst/TextureProgress").max_value)
	get_node("UI/BulletPlyr").update_maxbullet(get_node("plyrInst/BulletHealth").max_value)
		
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

	camera = current_scene.get_node("level/Camera2D")
	player.position = current_scene.get_node(str(spawn)).position #set plyr spawn
	camera.position = current_scene.get_node(str(spawn)).position #set camera spawn
	print(path)

func _process(_delta):
	if Input.is_action_pressed("menu"):
		var confirm = load("res://src/UI/saveConfirm.tscn").instance()
		self.add_child(confirm)
	#	confirm.offset = camera.position
		get_tree().paused = true
