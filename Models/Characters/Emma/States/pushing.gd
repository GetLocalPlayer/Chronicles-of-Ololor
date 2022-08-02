extends State


onready var run_speed = owner.run_speed
onready var push_speed = owner.push_speed
onready var gravity = owner.gravity
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")
onready var body = owner

var is_pushing: bool

func _enter():
	is_pushing = true
	anim_player.play("pushing", 0.15)
	
	
func _update(_delta):
	var velocity = Vector3.ZERO
	velocity.y = -gravity
	var direction = Vector3.ZERO
	if Input.is_action_pressed("run_left"):
		direction.z = 1
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		direction.z = -1
		armature.rotation_degrees = Vector3(0, 180, 0)
	velocity += direction * run_speed
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	is_pushing = false
	for i in body.get_slide_count():
		var collision = body.get_slide_collision(i)
		if collision.collider.is_in_group("pushable"):
			var pushable = collision.collider
			var normal = collision.normal
			if pushable.is_on_floor() and normal.dot(direction) < -0.95:
				pushable.move_and_slide(direction * push_speed, Vector3.UP, false, 4, PI/4, false)
				is_pushing = true
			
	
func _transition():
	if not body.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
		return "idle"
	if Input.is_action_pressed("crawling"):
		return "crawling"
	if not is_pushing:
		return "run"
		
