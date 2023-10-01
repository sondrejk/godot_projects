extends CharacterBody2D

var MOVESPEED = 200

func _physics_process(_delta):
	player_movement()
	move_and_slide()

func player_movement():
	position.y = 100
	if Input.is_action_pressed("ui_right") and position.x < 232:
		velocity.x = MOVESPEED
	elif Input.is_action_pressed("ui_left") and position.x > 8:
		velocity.x = -MOVESPEED
	else:
		velocity.x = 0

func death():
	get_tree().reload_current_scene()

func _on_hitbox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.has_method("enemy"):
		death()
