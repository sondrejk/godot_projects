extends RigidBody2D

var hit_force : float = 10

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var direction = global_position.direction_to(get_global_mouse_position())
		apply_impulse(direction * hit_force)
