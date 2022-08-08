extends State
class_name Idle


export (float) var time_to_idle = 10
onready var gravity = owner.gravity
onready var body = owner
onready var anim_player = owner.get_node("AnimationPlayer")
onready var timer = Timer.new()


var velocity = Vector3.ZERO


func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "start_idle_anim")
			
	
func start_idle_anim():
	anim_player.play("stand_2", 0.75, 0.5)


func _enter():
	var naked = true
	for child in owner.get_node("Skeleton").get_children():
		if child.name.begins_with("Cloth"):
			naked = naked and not child.visible
	if owner.health/owner.max_health <= 0.35:
		anim_player.play("stand_lowhp", 0.1)
	elif naked:
		anim_player.play("stand_nude", 0.1)
	else:
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
	velocity.y -= gravity
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	if body.is_on_floor():
		velocity.y = 0
