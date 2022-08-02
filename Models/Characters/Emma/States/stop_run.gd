extends State


onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("stop", 0.1)
	
	
func _transition():
	if owner.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return "jump"
		if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
			if Input.is_action_pressed("crawling"):
				return "crawling"
			else:
				return "run"
		if not anim_player.is_playing() and not Input.is_action_pressed("crawling"):
			return "idle"
	else:
		return "falling"
		
	
func _update(_delta):
	var gravity = owner.gravity
	var velocity = Vector3(0, -gravity, 0)
	owner.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
