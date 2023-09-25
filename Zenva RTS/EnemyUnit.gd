extends Unit

@export var detect_range : float = 100.0
@onready var game_manager = get_node("/root/Main")

func _process(delta):
	if target == null:
		for player in game_manager.players:
			if player == null:
				continue
			var distance = global_position.distance_to(player.global_position)
			if distance <= detect_range:
				set_target(player)
	
	_target_check()
