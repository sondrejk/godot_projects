extends Node2D

@onready var ui = get_node("CanvasLayer/UI") 
@onready var timer = get_node("enemy_spawn_timer")
var score : int = 0

# Preloads the enemy scene, so it can be added using the enemy timer
var enemy = preload("res://enemy.tscn")

func _process(delta):
	timer.wait_time -= (timer.wait_time / 50) * delta

# Adds the enemy as a child node once the timer runs out
func _on_enemy_spawn_timer_timeout():
	add_child(enemy.instantiate())

func add_score(amount):
	score += amount
	ui.text = str("SCORE: ", score)
