extends KinematicBody
class_name Pushable


export (float) var gravity = 5
export (float) var kick_damp = 0.9

var velocity = Vector3.ZERO
var kick_velocity = Vector3.ZERO


func kick(_velocity: Vector3):
	kick_velocity = _velocity


func _physics_process(delta):
	_overridable_physics_process(delta)
		
		
func _overridable_physics_process(_delta):
	velocity += Vector3.DOWN * gravity
	move_and_slide(velocity + kick_velocity, Vector3.UP, false, 4, PI/4, false)
	kick_velocity *= kick_damp
	if is_on_floor():
		velocity = Vector3.ZERO
		
		
