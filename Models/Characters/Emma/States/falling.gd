extends State


onready var gravity = owner.gravity
onready var run_speed = owner.run_speed
onready var body = owner
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")


var velocity: Vector3


func _enter():
	velocity = Vector3.ZERO
	anim_player.stop()
	anim_player.play("falling", 0.1)
	
	
func _update(_delta):
	velocity.y -= gravity
	velocity.z = 0
	if Input.is_action_pressed("run_left"):
		velocity.z = run_speed
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.z = -run_speed
		armature.rotation_degrees = Vector3(0, 180, 0)
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition():
	if body.is_on_floor():
		return "landing"
	if body.is_on_wall():
		for i in body.get_slide_count():
			var collision = body.get_slide_collision(i)
			if collision.collider_shape.is_in_group("walls"):
				return "wall_sliding"
	if body.double_jump_available and Input.is_action_just_pressed("jump"):
		body.double_jump_available = false
		return "jump"
	
	
func _exit():
	body.double_jump_available = true
