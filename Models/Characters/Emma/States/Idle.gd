extends State


onready var anim_player = owner.get_node("AnimationPlayer")
onready var gravity = owner.gravity
onready var body = owner

var velocity = Vector3.ZERO


func _transition():	
	if owner.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return "jump"
		if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
			if Input.is_action_pressed("crawling"):
				return "crawling"
			else:
				return "run"
	else:
		return "falling"
		
	
func _update(_delta):
	velocity.y -= gravity
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	if body.is_on_floor():
		velocity.y = 0
