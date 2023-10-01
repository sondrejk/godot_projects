extends Area2D

@onready var starting_position : Vector2 = Vector2(randi_range(-1800, 1800), -2000)
var move_speed : float = 5

# Gives starting position once 
func _ready():
	position = starting_position

func _process(_delta):
	position.y += move_speed
