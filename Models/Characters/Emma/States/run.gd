extends "move.gd"

onready var run_speed = owner.run_speed


# How long the character must run
# before having to play "stop" animation
export (float) var stop_run_time = 1 
var stop_time: float


func _ready():
	speed = run_speed

func _enter():
	anim_player.play("run", 0.15)
	stop_time = stop_run_time
	
	
func _update(delta):
	._update(delta)
	stop_time -= delta
	
func _transition():
	var new_state = ._transition()
	
	if new_state == null:
		if Input.is_action_pressed("crawling"):
			return "crawling"
		else:
			for i in body.get_slide_count():
				var collision = body.get_slide_collision(i)
				var collider = collision.collider
				if collider.is_in_group("pushable") and collider.is_on_floor():
					if abs(stepify(collision.normal.dot(body.get_floor_normal()), 0.01)) == 0.0: 
						return "pushing"
	
	if new_state in ["stand", "kneel"]:
		if stop_time <= 0:
			new_state = "stop_run"
			
	return new_state




