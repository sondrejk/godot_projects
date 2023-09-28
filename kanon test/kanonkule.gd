extends RigidBody2D
var move_speed : float = 10

func _process(delta):
	global_position.x += 100 * delta
	
