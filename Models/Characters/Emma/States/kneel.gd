extends "idle.gd"


func _enter():
	anim_player.play("kneel", 0.1)
	
	
func _transition():
	var new_state = ._transition()
	if new_state == null:
		if not Input.is_action_pressed("crawling"):
			new_state = "stand"
	return new_state 
