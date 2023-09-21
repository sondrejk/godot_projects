extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var score : int = 0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")

func _physics_process(delta):
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		
	velocity.x = 0
	
	# Player movement
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
		
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed

	if Input.is_key_pressed(KEY_UP) and is_on_floor():
		velocity.y -= jump_force
			
	move_and_slide()
	
	# Death by falling out of level
	if global_position.y >= 100:
		game_over()
	
func game_over():
	get_tree().reload_current_scene()

func add_score(amount):
	score += amount
	score_text.text = str("SCORE: ", score)
