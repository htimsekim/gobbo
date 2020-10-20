extends Node
const playerResource = preload("res://src/characters/Player.tscn")
const UIResource = preload("res://src/UI/ui.tscn")
var current_scene = null
var previous_scene = null
var previous_scene_path = null
var previous_scene_x2 = null
var previous_scene_x2_path = null
var camera
var player
var ui
var earthquake_happened = [false, "-prequake", "-postquake"]
var game_data = {}
var path
var heart_boxes = []

func _physics_process(_delta):
	if Input.is_action_just_pressed("Dbullet") and get_node("plyrInst/BulletHealth").max_value > 3: #decrease bullet for TESTING ONLY
		get_node("plyrInst/BulletHealth").max_value -= 1
		Global.player.get_node("BulletHealth").value = Global.player.get_node("BulletHealth").max_value
		get_node("UI/BulletPlyr").update_maxbullet(get_node("plyrInst/BulletHealth").max_value)
	if Input.is_action_just_pressed("Ibullet")and get_node("plyrInst/BulletHealth").max_value < 10: #increase bullet for TESTING ONLY
		get_node("plyrInst/BulletHealth").max_value += 1
		Global.player.get_node("BulletHealth").value = Global.player.get_node("BulletHealth").max_value
		get_node("UI/BulletPlyr").update_maxbullet(get_node("plyrInst/BulletHealth").max_value)

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
	get_tree().get_root().remove_child(current_scene)
	previous_scene_x2 = previous_scene
	previous_scene = current_scene
	previous_scene_x2_path = previous_scene_path
	previous_scene_path = current_scene.filename
	if path == previous_scene_x2_path:
		get_tree().get_root().add_child(previous_scene_x2)
		camera = previous_scene_x2.get_node("level/Camera2D")
		player.position = previous_scene_x2.get_node(str(spawn)).position #set plyr spawn
		camera.position = previous_scene_x2.get_node(str(spawn)).position #set camera spawn
		current_scene = previous_scene_x2
	else:
		if previous_scene_x2:
			previous_scene_x2.free()
		var s = ResourceLoader.load(path) # Load the new scene.
		current_scene = s.instance() # Instance the new scene.
		get_tree().get_root().add_child(current_scene) # Add it to the active scene, as child of root.
		#Optionally, to make it compatible with the SceneTree.change_scene() API.
		get_tree().set_current_scene(current_scene)
	
		camera = current_scene.get_node("level/Camera2D")
		player.position = current_scene.get_node(str(spawn)).position #set plyr spawn
		camera.position = current_scene.get_node(str(spawn)).position #set camera spawn

func save_game(saveName):
	var f = File.new()
	if f.open_encrypted_with_pass("user://" + saveName + ".bin", File.WRITE, "mypass") != 0: 
		print("Can't save file")
	else:
		game_data = {"savescene": current_scene.filename}
		game_data = {"eathquake": earthquake_happened}
		game_data = {"maxhealth": get_node("plyrInst/TextureProgress").max_value}
		game_data = {"maxbullet": get_node("plyrInst/BulletHealth").max_value}
		f.store_var(game_data)
		f.close()
			
func load_game(saveName):
	var file = File.new()
	file.open_encrypted_with_pass("user://" + saveName + ".bin", File.READ, "mypass")
	var game_data = file.get_var()
	file.close()
	
	#load game_data
	earthquake_happened = game_data.eathquake
	get_node("UI/HeartBarPlyr").update_maxhealth(game_data.maxhealth)
	get_node("UI/BulletPlyr").update_maxbullet(game_data.maxbullet)
	
	load_player()
	goto_scene(game_data.savescene,"level/spawns/spawn1")
