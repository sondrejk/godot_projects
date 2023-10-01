extends Area2D

@onready var starting_position : Vector2 = Vector2(randi_range(-1800, 1800), -2000)
@onready var game_manager : Node2D = get_node("/root/Main")
var move_speed : float = 5


# Gives starting position once 
func _ready():
	position = starting_position

func _process(_delta):
	position.y += move_speed

	if global_position.y >= 1300:
		game_manager.add_score(1)
		queue_free()

