extends State


onready var crawling_speed = owner.crawling_speed
onready var gravity = owner.gravity
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")
onready var body = owner


func _enter():
	anim_player.play("crawling", 0.15)
	
	
func _update(_delta):
	var velocity = Vector3.ZERO
	velocity.y = -gravity
		
	if Input.is_action_pressed("run_left"):
		velocity.z = crawling_speed
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.z = -crawling_speed
		armature.rotation_degrees = Vector3(0, 180, 0)
		
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition(_delta):
	if not body.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
		return "idle"
	if not Input.is_action_pressed("crawling"):
		return "run"
	
	
func _exit(_delta):
	pass
