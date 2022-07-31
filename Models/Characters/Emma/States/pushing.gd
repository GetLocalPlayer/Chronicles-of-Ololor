extends State


onready var run_speed = owner.run_speed
onready var push_speed = owner.push_speed
onready var gravity = owner.gravity
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")
onready var body = owner

var pushable: RigidBody

func _enter():
	anim_player.play("pushing")
	
	
func _update(_delta):
	var velocity = Vector3.ZERO
	velocity.y = -gravity
	if Input.is_action_pressed("run_left"):
		velocity.z = run_speed
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.z = -run_speed
		armature.rotation_degrees = Vector3(0, 180, 0)
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	pushable = null
	for i in body.get_slide_count():
		var collision = body.get_slide_collision(i)
		if collision.collider.is_in_group("pushable"):
			pushable = collision.collider
			var impulse = Vector3.ZERO
			impulse.z = sign(velocity.z) * (push_speed - abs(pushable.linear_velocity.z)) * pushable.mass
			pushable.apply_central_impulse(impulse)
			
	
	
func _transition(_delta):
	if not body.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
		return "idle"
	if Input.is_action_pressed("crawling"):
		return "crawling"
	if pushable == null:
		return "run"
		
	
func _exit(_delta):
	pass
