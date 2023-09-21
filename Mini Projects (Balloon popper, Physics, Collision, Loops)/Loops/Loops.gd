extends Node2D

@export var spawn_count : int = 500
var star_scene = preload("res://Loops/star.tscn")

func _ready():
	for i in spawn_count:
		var star = star_scene.instantiate()
		var star_size = randf_range(0.5, 2.0)
		
		add_child(star)
		
		star.position.x = randi_range(-550, 550)
		star.position.y = randi_range(-300, 300)
		star.scale.y = star_size
		star.scale.x = star_size
