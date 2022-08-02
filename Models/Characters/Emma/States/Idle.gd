extends State


export (float) var time_to_idle = 10

onready var anim_player = owner.get_node("AnimationPlayer")
onready var timer = Timer.new()


func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "start_idle_anim")
	
func start_idle_anim():
	anim_player.play("stand_2", 0.75, 0.5)


func _enter():
	anim_player.play("stand", 0.1)
	timer.start(time_to_idle)
	
	
func _exit():
	timer.stop()
	
	
func _transition():	
	if owner.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			return "jump"
		if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
			if Input.is_action_pressed("crawling"):
				return "crawling"
			else:
				return "run"
		if Input.is_action_pressed("crawling"):
			return "kneel"
		if Input.is_action_just_pressed("attack"):
			return "attack"
	else:
		return "falling"
		
	
func _update(_delta):
	var gravity = owner.gravity
	var velocity = Vector3(0, -gravity, 0)
	owner.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
