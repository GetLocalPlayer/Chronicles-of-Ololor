extends State


onready var wall_sliding_speed = owner.wall_sliding_speed
onready var run_speed = owner.run_speed
onready var body = owner
onready var anim_player = owner.get_node("AnimationPlayer")
onready var audio = owner.get_node("Sounds/Landing")
onready var armature = owner.get_node("Skeleton")


enum SlidingType {LEFT, RIGHT}

var sliding_type: int


func _enter():
	var position: Vector3
	for i in body.get_slide_count():
		var collision = body.get_slide_collision(i)
		if collision.collider_shape.is_in_group("walls"):
			position = collision.position
			break
	anim_player.stop(true)
	anim_player.play("sliding")
	if position.z > body.translation.z:
		armature.rotation_degrees = Vector3.ZERO
		sliding_type = SlidingType.LEFT
	else:
		armature.rotation_degrees.y = -180
		sliding_type = SlidingType.RIGHT
	audio.play_random()
	
	
func _update(_delta):
	var velocity = Vector3(0, -wall_sliding_speed, 0)
	if Input.is_action_just_pressed("run_left"):
		velocity.z = run_speed
	elif Input.is_action_just_pressed("run_right"): 
		velocity.z = -run_speed
	else:
		match sliding_type:
			SlidingType.LEFT:
				velocity.z = run_speed
			SlidingType.RIGHT:
				velocity.z = -run_speed
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition(_delta):
	if body.is_on_floor():
		return "idle"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if not body.is_on_wall():
		return "falling"
	
	
func _exit(_delta):
	pass
