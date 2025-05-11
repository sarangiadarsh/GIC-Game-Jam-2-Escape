class_name FallState

extends State



func _update(delta: float) -> void:
	#GLOBAL.player.animation_player.play("Fall/Fall")
	if GLOBAL.player.velocity.y == 0:
		if GLOBAL.player.velocity.x != 0 or GLOBAL.player.velocity.z != 0:
			transition.emit("WalkState")
			print("Walking")
		
		if GLOBAL.player.velocity.x == 0 and GLOBAL.player.velocity.z == 0:
			transition.emit("IdleState")
			print("Idling")
		print("Grounded")
