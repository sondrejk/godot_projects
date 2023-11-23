extends Node3D

var falling := false
var gravity := 0.0

@export_subgroup("Audio")
@export var fmod_event_fall : EventAsset

func _process(delta):
	scale = scale.lerp(Vector3(1, 1, 1), delta * 10) # Animate scale
	
	position.y -= gravity * delta
	
	if position.y < -10:
		queue_free() # Remove platform if below threshold
	
	if falling:
		gravity += 0.25


func _on_body_entered(_body):
	if !falling:
		RuntimeManager.play_one_shot_attached(fmod_event_fall, self)
		scale = Vector3(1.25, 1, 1.25) # Animate scale
		
	falling = true
