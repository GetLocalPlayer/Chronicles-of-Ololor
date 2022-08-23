extends "move.gd"


onready var crawling_speed = owner.crawling_speed


func _ready():
	speed = crawling_speed
	
	
func _enter():
	anim_player.play("crawling", 0.15)
	
	
func _transition():
	var new_state = ._transition()
	if new_state == null:
		if not Input.is_action_pressed("crawling"):
			new_state = "run"
	return new_state
