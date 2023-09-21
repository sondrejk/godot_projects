extends Area2D

var bob_height : float = 5
var bob_speed : float = 5
var t : float = 0.0

@onready var start_y  : float = global_position.y

func _process(delta):
	t += delta
	
	# Sine function to bob the coin up and down
	var sint = (sin(t * bob_speed) + 1) / 2
	global_position.y = start_y + (sint * bob_height)

# Adds score and removes coin after collision
func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.add_score(1)
		queue_free()
