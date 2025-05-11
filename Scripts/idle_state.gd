class_name IdleState

extends State


func _update(delta: float) -> void:
	GLOBAL.player.animation_player.play("Idle/Idle")
	if GLOBAL.player.velocity.x != 0 or GLOBAL.player.velocity.z != 0:
		transition.emit("WalkState")
		print("Walking")
	if GLOBAL.player.velocity.y > 0:
		transition.emit("JumpState")
		print("JumpState")
