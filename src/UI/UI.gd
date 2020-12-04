extends HBoxContainer
var reload = false

func update_maxhealth(maxvalue):
	for h in 10:
		get_child(h).visible = false
	for h in maxvalue:
		if h < 10:
			get_child(h).visible = true

func update_maxbullet(maxvalue):
	for h in 10:
		get_child(h).visible = false
		get_child(h).get_child(1).play("full")	
	for h in maxvalue:
		if h < 10:
			get_child(h).visible = true
	reload = false
	
func update_health(value):
	for i in get_child_count():
		if value >= i + 1 :
			get_child(i).get_child(0).frame = 0 #full
		elif value > i:  
			get_child(i).get_child(0).frame = 1 #half full
		else:
			get_child(i).get_child(0).frame = 2 #empty
	
func update_bullet(value):
	if reload == true and get_node("../reloadTimer").time_left < 0: #if we need to reload and timer hasn't started, start it
		get_node("../reloadTimer").start()
		
	for i in get_child_count():
		if value == -1: #reload
			reload = true
			get_child(i).get_child(1).play("reload")

		if reload == false:
			if value >= i + 1:
				get_child(i).get_child(1).play("full")
			else:
				get_child(i).get_child(1).play("empty")

func _on_reloadTimer_timeout():
	Global.player.get_node("BulletHealth").value = Global.player.get_node("BulletHealth").max_value
	reload = false
