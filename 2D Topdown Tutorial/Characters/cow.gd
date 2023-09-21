extends CharacterBody2D

enum COW_STATE { IDLE, WALK }

@export var move_speed : float = 20
@export var idle_timer : float = 3
@export var walk_timer : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer

var move_direction : Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready():
	pick_new_state()
	
func _physics_process(_delta):
	if(current_state == COW_STATE.WALK):
		velocity = move_direction * move_speed
		move_and_slide()
	
func select_new_destination():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1) 
	)
	
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false

func pick_new_state():
	if (current_state == COW_STATE.IDLE):
		state_machine.travel("Walk right")
		current_state = COW_STATE.WALK
		select_new_destination()
		timer.start(walk_timer)
	elif (current_state == COW_STATE.WALK):
		state_machine.travel("Idle right")
		current_state = COW_STATE.IDLE	
		timer.start(idle_timer)


func _on_timer_timeout():
	pick_new_state()
