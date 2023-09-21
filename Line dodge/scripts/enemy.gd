extends CharacterBody2D

var MOVESPEED = 100

func _ready():
	position = Vector2(randi_range(8, 232), -10)

func _physics_process(_delta):
	velocity.y = MOVESPEED
	move_and_slide()
	
	if position.y > 145:
		queue_free()
	
func enemy():
	pass
