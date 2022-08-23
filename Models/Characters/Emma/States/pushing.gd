extends "move.gd"


onready var run_speed = owner.run_speed
onready var push_speed = owner.push_speed

var is_pushing: bool


func _ready():
	speed = run_speed
	
	
func _enter():
	is_pushing = true
	anim_player.play("pushing", 0.15)
	
	
func _update(delta):
	._update(delta)
	var direction = armature.global_transform.basis.z.normalized()
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
	var new_state = ._transition()
	if new_state == null:
		if Input.is_action_pressed("crawling"):
			return "crawling"
		if not is_pushing:
			return "run"
	return new_state
		
