extends CharacterBody2D

var SPEED = 300


func _physics_process(delta):
	velocity = Vector2(0, 0)
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= 1
	
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += 1
		
	if Input.is_key_pressed(KEY_UP):
		velocity.y -= 1
	
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += 1
	
	velocity *= SPEED
		
	move_and_slide()
