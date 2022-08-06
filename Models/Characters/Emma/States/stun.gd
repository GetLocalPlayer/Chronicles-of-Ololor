extends "res://Models/Characters/Emma/States/Idle.gd"


onready var body = owner


func _enter():
	if body.is_on_floor():
		anim_player.play("landing_hard", 0.15)
	else:
		anim_player.play("falling_stunned", 0.15)
	

func _update(delta):
	._update(delta)
	if body.is_on_floor() and anim_player.current_animation == "falling_stunned":
		anim_player.play("landing_hard", 0.1)
	
	
func _transition():
	if not anim_player.is_playing():
		return "idle"
