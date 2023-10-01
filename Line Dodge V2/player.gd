extends Area2D

var move_speed : float = 25

# Function that calls every frame
func _process(_delta):
	player_movement()
	
# Player movement, makes sure you cant move outside screen
func player_movement():
	if Input.is_action_pressed("ui_left") and position.x > -1800:
		position.x -= move_speed
		
	if Input.is_action_pressed("ui_right") and position.x < 1800:
		position.x += move_speed	

# Restarts game if player gets hit
func _on_area_entered(area):
	get_tree().reload_current_scene()
