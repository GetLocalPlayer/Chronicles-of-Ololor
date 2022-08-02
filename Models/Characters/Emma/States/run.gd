extends State

onready var run_speed = owner.run_speed
onready var gravity = owner.gravity
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")
onready var body = owner

# How long the character must run
# before having to play "stop" animation
export (float) var stop_run_time = 1 
var stop_time: float


func _enter():
	anim_player.play("run", 0.15)
	stop_time = stop_run_time
	
	
func _update(delta):
	var velocity = Vector3.ZERO
	velocity.y = -gravity
	stop_time -= delta
		
	if Input.is_action_pressed("run_left"):
		velocity.z = run_speed
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.z = -run_speed
		armature.rotation_degrees = Vector3(0, 180, 0)
		
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition():
	if not body.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	for i in body.get_slide_count():
		var collision = body.get_slide_collision(i)
		if collision.collider.is_in_group("pushable"):
			return "pushing"
	if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
		if Input.is_action_pressed("crawling"):
			return "kneel"
		elif stop_time <= 0:
			return "stop_run"
		else:
			return "idle"
	if Input.is_action_pressed("crawling"):
			return "crawling"

