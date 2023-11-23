extends CharacterBody3D

signal coin_collected

@export_subgroup("Components")
@export var view: Node3D

@export_subgroup("Properties")
@export var movement_speed = 250
@export var jump_strength = 7

@export_subgroup("Audio")
@export var event_jump : EventAsset
@export var event_land : EventAsset
@export var event_footstep : EventAsset

var movement_velocity: Vector3
var rotation_direction: float
var gravity = 0

var previously_floored = false

var jump_single = true
var jump_double = true
var jump_triple = true

var coins = 0

@onready var particles_trail = $ParticlesTrail
@onready var model = $Character
@onready var animation = $Character/AnimationPlayer

var left_foot_has_played = false
var right_foot_has_played = false

# Functions

func _physics_process(delta):
	
	# Handle functions
	
	handle_controls(delta)
	handle_gravity(delta)
	
	handle_effects()
	
	# Movement

	var applied_velocity: Vector3
	
	applied_velocity = velocity.lerp(movement_velocity, delta * 10)
	applied_velocity.y = -gravity
	
	velocity = applied_velocity
	move_and_slide()
	
	# Rotation
	
	if Vector2(velocity.z, velocity.x).length() > 0:
		rotation_direction = Vector2(velocity.z, velocity.x).angle()
		
	rotation.y = lerp_angle(rotation.y, rotation_direction, delta * 10)
	
	# Falling/respawning
	
	if position.y < -10:
		get_tree().reload_current_scene()
	
	# Animation for scale (jumping and landing)
	
	model.scale = model.scale.lerp(Vector3(1, 1, 1), delta * 10)
	
	# Animation when landing
	
	if is_on_floor() and gravity > 2 and !previously_floored:
		model.scale = Vector3(1.25, 0.75, 1.25)
		RuntimeManager.play_one_shot(event_land, self)
	
	previously_floored = is_on_floor()

# Handle animation(s)

func handle_effects():
	
	particles_trail.emitting = false
	
	if is_on_floor():
		if abs(velocity.x) > 1 or abs(velocity.z) > 1:
			animation.play("walk", 0.5)
			particles_trail.emitting = true
			handle_footstep_sfx()
		else:
			animation.play("idle", 0.5)
	else:
		animation.play("jump", 0.5)

# Handle movement input

func handle_controls(delta):
	
	# Movement
	
	var input := Vector3.ZERO
	
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	input = input.rotated(Vector3.UP, view.rotation.y).normalized()
	
	movement_velocity = input * movement_speed * delta
	
	# Jumping
	
	if Input.is_action_just_pressed("jump"):
		
		if jump_single or jump_double or jump_triple:
			RuntimeManager.play_one_shot(event_jump, self)
		
		if jump_double:
			
			gravity = -jump_strength
			
			jump_double = false
			model.scale = Vector3(0.5, 1.5, 0.5)
		
		elif jump_triple:
			gravity = -jump_strength
			
			jump_triple = false
			model.scale = Vector3(0.5, 1.5, 0.5)
			
		if jump_single: jump()

# Handle gravity

func handle_gravity(delta):
	
	gravity += 25 * delta
	
	if gravity > 0 and is_on_floor():
		
		jump_single = true
		gravity = 0

# Jumping

func jump():
	
	gravity = -jump_strength
	
	model.scale = Vector3(0.5, 1.5, 0.5)
	
	jump_single = false
	jump_double = true
	jump_triple = true

# Collecting coins

func collect_coin():
	
	coins += 1
	
	coin_collected.emit(coins)
	FMODStudioModule.get_studio_system().set_parameter_by_name("CoinCount", coins, false)

func handle_footstep_sfx():
	var t = animation.current_animation_position / animation.current_animation_length
	
	if (t < 0.25):
		left_foot_has_played = false
		right_foot_has_played = false
	
	if (!left_foot_has_played && t > 0.25):
		RuntimeManager.play_one_shot(event_footstep, self)
		left_foot_has_played = true
	if (!right_foot_has_played && t > 0.75):
		RuntimeManager.play_one_shot(event_footstep, self)
		right_foot_has_played = true
