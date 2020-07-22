class_name Gun
extends Position2D

onready var Bullet = preload("res://src/Objects/projectile.tscn")

func shoot():
	var b = Bullet.instance()
	b.transform = $ShootPoint.global_transform
	get_node("/root/Global/").add_child(b)
	b.rotation = rotation

	return true
