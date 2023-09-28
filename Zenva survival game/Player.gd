extends CharacterBody3D

var camera : Camera3D
var head : Node3D

var move_speed : float = 5.0
var jump_force : float = 5.0
var gravity : float = 9

var look_sensitivity : float = 0.5
var min_x_rotation : float = -85
var max_x_rotation : float = 85
var mouse_direction : Vector2

func _ready():
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)

func _input(event):
	pass
	
func _process(delta):
	camera.position = head.global_position

func _physics_process(delta):
	pass


	
