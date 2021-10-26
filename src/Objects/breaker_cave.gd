extends KinematicBody2D

onready var player = Global.get_node("plyrInst")
var bodytimer
var triggered = false

func _ready():
	Global.player.connect("collided", self, "_on_Character_collided")
	$Sprite/AnimationPlayer.clear_queue()
	$Sprite/AnimationPlayer.queue("break")
	$Sprite/AnimationPlayer.seek(0, true)
	$Sprite/AnimationPlayer.stop()
	

#func _physics_process(delta):
#	if triggered:
#		$Timer.start()
#		bodytimer.get_node(\"Sprite/AnimationPlayer\").play(\"break\")

#func _on_Character_collided(body):
#	if \"breaker\" in body.name:
#		if player.is_on_floor() and body.global_position.y > Global.player.global_position.y:
#			bodytimer = body
#			triggered = true
#			self.queue_free()

func _on_Timer_timeout():
	get_node(".").visible = false
	get_node("CollisionShape2D").disabled = true
	$BlockRespawn.start()


func _on_TopDetector_body_entered(body):
	if body == player and player.is_on_floor():
		$Timer.start()
		$Sprite/AnimationPlayer.play("break")


func _on_BlockRespawn_timeout():
	get_node(".").visible = true
	get_node("CollisionShape2D").disabled = false
	#$Sprite/AnimationPlayer.clear_queue()
	#$Sprite/AnimationPlayer.queue("break")
	$Sprite/AnimationPlayer.stop()
	$Sprite/AnimationPlayer.seek(0, true)
