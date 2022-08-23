extends State


# speed must be defined in subclasses
var speed = 0

onready var gravity = owner.gravity
onready var anim_player = owner.get_node("AnimationPlayer")
onready var armature = owner.get_node("Skeleton")
onready var body = owner

var velocity: Vector3


func _enter():
	velocity = Vector3.ZERO
	


func _update(delta):
	velocity.y = -gravity
	if Input.is_action_pressed("run_left", true):
		velocity.z = speed
		armature.rotation_degrees = Vector3.ZERO
	elif Input.is_action_pressed("run_right", true):
		velocity.z = -speed
		armature.rotation_degrees = Vector3(0, 180, 0)
	body.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	if body.is_on_floor():
		velocity.y = 0
	
	
func _transition():
	if not body.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if not Input.is_action_pressed("run_left") and not Input.is_action_pressed("run_right"):
		if Input.is_action_pressed("crawling"):
			return "kneel"
		else:
			return "stand"

