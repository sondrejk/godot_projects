extends Node2D

var enemy = preload("res://scenes/enemy.tscn")

func _on_enemy_spawn_timer_timeout():
	add_child(enemy.instantiate())
