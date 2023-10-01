extends Node2D

# Preloads the enemy scene, so it can be added using the enemy timer
var enemy = preload("res://enemy.tscn")

# Adds the enemy as a child node once the timer runs out
func _on_enemy_spawn_timer_timeout():
	add_child(enemy.instantiate())
