extends "idle.gd"


func _enter():
	anim_player.play("stop", 0.1)
	
	
func _transition():
	var new_state = ._transition()
	if new_state == null:
		if not anim_player.is_playing():
			if Input.is_action_pressed("crawling"):
				new_state = "kneel"
			else:
				new_state = "stand"
	return new_state
