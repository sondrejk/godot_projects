extends StaticBody2D

@onready var kanonkule = preload("res://kanonkule.tscn")


func _on_skytetimer_timeout():
	add_child(kanonkule.instantiate())
