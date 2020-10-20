extends Area2D

func _on_heartbox_body_entered(body):
	if body.is_in_group("plyr") and Global.player.get_node("TextureProgress").max_value < 10:	
		Global.player.get_node("TextureProgress").max_value += 1 
		Global.player.get_node("TextureProgress").value = Global.player.get_node("TextureProgress").max_value
		Global.player.updatehealth()
		#queue_free()
		
		#TreeItem.remove_child(self)
		#if tree.get_selected() != null: print("d")
		#.get_parent().remove_child(self)
		remove_child(self)
		
		self.queue_free()
