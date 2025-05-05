extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var visuals: Node3D = $visuals
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var springarmpivot: Node3D = $springarmpivot


	
func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity+= get_gravity() * delta
		if velocity.y >  0:
			velocity += get_gravity() * delta  *1.7
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("Jump/Jump")
	
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if animation_player.current_animation != ("Jump/Jump"):
			animation_player.play("Walk/Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if animation_player.current_animation != ("Jump/Jump"):
			animation_player.play("Idle/Idle")
		
	if is_on_floor() and animation_player.current_animation == ("Jump/Jump"):
		pass
		
	
	move_and_slide()
