extends Area2D

func _on_Hurtbox_area_entered(area):
	if area.name == "Hitbox" and Global.player.knockback == false:
		$"../".set_collision_mask(6) #colliding, so turn collision off
		set_collision_mask(6)
		$Timer.start() #turn collision on
		Global.player.playerdamage($"../TextureProgress".step, $"../".position) #call enemydamage to damage, blink, and knockback player

func _on_Timer_timeout():
	$"../".set_collision_mask(7)
	set_collision_mask(7)
	Global.player.blink = false
