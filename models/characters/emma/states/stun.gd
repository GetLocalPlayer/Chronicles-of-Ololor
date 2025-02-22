extends "idle.gd"


func _enter():
	if body.is_on_floor():
		anim_player.play("landing_hard", 0.1)
	else:
		anim_player.play("falling_stunned", 0.1)
		

func _update(delta):
	._update(delta)
	if not body.is_on_floor() and anim_player.current_animation != "falling_stunned":
		anim_player.play("falling_stunned", 0.15)
	if body.is_on_floor() and anim_player.is_playing() and anim_player.current_animation != "landing_hard":
		anim_player.play("landing_hard", 0.1)
	
	
func _transition():
	if not anim_player.is_playing():
		return "stand"
