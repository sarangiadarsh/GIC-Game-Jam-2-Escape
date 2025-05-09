extends CharacterBody3D


const SPEED = 2.0
const JUMP_VELOCITY = 6
const SPRINT_SPEED = 3

@onready var visuals: Node3D = $visuals
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var springarmpivot: Node3D = $springarmpivot
@onready var camera: Camera3D = $springarmpivot/Camera3D

@export  var rotation_lerp_power:float  = 5.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotation.y -= event.relative.x *  GLOBAL.sensitivity
		rotation.y = wrapf(rotation.y,0.0, TAU)
		visuals.rotation.y += event.relative.x *  GLOBAL.sensitivity
	
func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		velocity+= get_gravity() * delta
		if velocity.y >  0:
			velocity += get_gravity() * delta  *1.5
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("Jump/Jump")
		
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		rotation.y = wrapf(rotation.y,0.0, TAU)	
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		visuals.look_at(position +direction)
		if animation_player.current_animation != ("Jump/Jump"):
			animation_player.play("Walk/Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if animation_player.current_animation != ("Jump/Jump"):
			animation_player.play("Idle/Idle")
	
	
	move_and_slide()
