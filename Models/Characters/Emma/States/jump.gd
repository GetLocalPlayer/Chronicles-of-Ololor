extends State


onready var gravity = owner.gravity
onready var run_speed = owner.run_speed
onready var jump_speed = owner.jump_speed
onready var anim_player = owner.get_node("AnimationPlayer")
onready var body = owner
onready var armature = owner.get_node("Skeleton")
onready var audio_voice = owner.get_node("Sounds/JumpVoice")


var dust = preload("res://models/effects/dust_small/dust_small.tscn")

var velocity: Vector3


func spawn_dust():
	var instance = dust.instance()
	body.add_child(instance)
	instance.set_as_toplevel(true)
	instance.translation = body.translation
	instance.get_node("AnimationPlayer").play("birth&queue_free", -1, 2)
	return instance	
	
	
func _enter():
	velocity = Vector3(0, jump_speed, 0)
	anim_player.stop(true)
	anim_player.play("rolling")
	if not body.is_on_floor() and body.double_jump_available:
		body.double_jump_available = false
	if body.is_on_floor() and body.double_jump_available:
		var instance = spawn_dust()
		var rot = armature.get_rotation()
		instance.set_rotation(rot)
		if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
			instance = spawn_dust()
			instance.set_rotation(rot)
			instance.rotate_y(PI)
	audio_voice.play_random()

	
func _transition():
	if body.is_on_wall():
		for i in body.get_slide_count():
			var collision = body.get_slide_collision(i)
			if collision.collider_shape.is_in_group("walls"):
				return "wall_sliding"
	if velocity.y < 0:
		return "falling"
		
	
func _update(_delta):
	velocity.y -= gravity
	velocity.z = 0
	if Input.is_action_pressed("run_left"):
		velocity.z = run_speed
		armature.rotation_degrees = Vector3.ZERO
	if Input.is_action_pressed("run_right"):
		velocity.z = -run_speed
		armature.rotation_degrees = Vector3(0, 180, 0)
	if Input.is_action_just_pressed("jump") and body.double_jump_available:
		body.double_jump_available = false
		velocity.y = jump_speed
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
