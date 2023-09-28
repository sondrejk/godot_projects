extends CharacterBody3D

var camera : Camera3D
var head : Node3D

var move_speed : float = 5.0
var jump_force : float = 5.0
var gravity : float = 9

var look_sensitivity : float = 0.5
var min_x_rotation : float = -85
var max_x_rotation : float = 85
var mouse_direction : Vector2

func _ready():
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)

func _input(event):
	if event is InputEventMouseMotion:
		camera.rotation_degrees.x += event.relative.y * -look_sensitivity
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rotation, max_x_rotation)
		camera.rotation_degrees.y += event.relative.x * -look_sensitivity
	
func _process(delta):
	camera.position = head.global_position

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = camera.basis.z * input.y + camera.basis.x * input.x
	direction.y = 0
	direction = direction.normalized()
	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed
	move_and_slide()
