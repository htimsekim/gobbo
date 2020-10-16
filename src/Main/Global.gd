extends Node
const playerResource = preload("res://src/Objects/Player.tscn")
const UIResource = preload("res://src/levels/ui.tscn")
var current_scene = null
var camera
var player
var ui
var earthquake_happened = [false, "-prequake", "-postquake"]
var prevScene = null
var prevprevScene = null
var checkscene = ""

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
	#prevScene = current_scene
	#if prevprevScene != null:
	checkscene = "res://src/levels/" + current_scene.name + ".tscn"
	print(path)
	var s = ResourceLoader.load(path) # Load the new scene.
	print(path)
	print(checkscene)


	if path != checkscene:
		current_scene = s.instance() # Instance the new scene.
		if prevprevScene != null:
			prevprevScene.queue_free()
		get_tree().get_root().add_child(current_scene) # Add it to the active scene, as child of root.
		#Optionally, to make it compatible with the SceneTree.change_scene() API.
		get_tree().set_current_scene(current_scene)
#	if prevprevScene != null and prevprevScene == current_scene:
		
	#if get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 3) != null:
	#	prevScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 3)
		
	#if prevScene != null and prevScene.name != "Global" and current_scene != null:
	#	var test = prevScene.name
	#	get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 3).queue_free()	
	#	get_tree().get_root().add_child(current_scene) # Add it to the active scene, as child of root.
		#Optionally, to make it compatible with the SceneTree.change_scene() API.
	#	get_tree().set_current_scene(current_scene)
	#elif prevScene == currScene and currScene.name != "Global":
	#	get_tree().get_root().add_child(currScene) # Add it to the active scene, as child of root.
		#Optionally, to make it compatible with the SceneTree.change_scene() API.
	#	get_tree().set_current_scene(currScene)
	prevprevScene = prevScene
	#elif current_scene == currScene and currScene.name != "Global":
		#get_tree().get_root().add_child(currScene) # Add it to the active scene, as child of root.
		#Optionally, to make it compatible with the SceneTree.change_scene() API.
		#get_tree().set_current_scene(currScene)
	#	currScene.visible = true

		
		
	camera = current_scene.get_node("level/Camera2D")
	player.position = current_scene.get_node(str(spawn)).position #set plyr spawn
	camera.position = current_scene.get_node(str(spawn)).position #set camera spawn
#	currScene.visible = true
	#prevScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() - 3)
#	if prevScene != null and prevScene.name != "Global":
#		prevScene.queue_free()
	
func _process(_delta):
	if Input.is_action_pressed("menu"):
		var confirm = load("res://src/UI/saveConfirm.tscn").instance()
		self.add_child(confirm)
		get_tree().paused = true
