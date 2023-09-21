extends Area2D

@export var move_speed : float = 30.0
@export var move_direction : Vector2

var start_pos : Vector2
var target_pos : Vector2

func _ready():
	start_pos = global_position
	target_pos = start_pos + move_direction
	
func _process(delta):
	# Moves the enemy between its starting point and a point relative to it set in the inspector
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_direction
		else:
			target_pos = start_pos

# Resets player if collision
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.game_over()
