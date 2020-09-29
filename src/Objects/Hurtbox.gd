extends Area2D
onready var player = Global.get_node("plyrInst")

func _on_Hurtbox_area_entered(area):
	if area.name == "Hitbox" and player.knockback == false:
		player.playerdamage($"../TextureProgress".step, $"../".position) #call enemydamage to damage, blink, and knockback player
		$"../".set_collision_mask(6) #colliding, so turn collision off
		set_collision_mask(6)
		$Timer.start() #turn collision on

func _on_Timer_timeout():
	$"../".set_collision_mask(7)
	set_collision_mask(7)
	player.knockback = false
	$Timer.stop()
