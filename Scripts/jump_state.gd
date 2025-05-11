class_name JumpState

extends State


func _update(delta: float) -> void:
	GLOBAL.player.animation_player.play("Jump/Jump")
	if GLOBAL.player.velocity.y < 0:
		transition.emit("FallState")
		print("Falling")
