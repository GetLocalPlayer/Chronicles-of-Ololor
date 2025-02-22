extends Spatial


signal attack(attack_type)
signal grasp_started # Emmited from the animation player
signal grasp_ended # Emmited from the animation player
signal upper_left_grasp # Emmited from the animation player
signal upper_right_grasp # Emmited from the animation player
signal spitout_frame


export (int) var health = 100 setget set_health
export (int) var max_health = 100
onready var health_bar = get_node("HealthBar")
enum AttackType {FAR_LEFT, LEFT, CENTER, RIGHT, FAR_RIGHT}


func is_alive() -> bool:
	return health > 0
	
	
func set_health(new_value):
	if new_value < 0:
		health = 0
	elif new_value > max_health:
		health = max_health
	else:
		health = new_value
	health_bar.value = health
	if health == 0 and $States.current_state != "death":
		$States._change_state("death")
	

func attack(type: int):
	match type:
		AttackType.FAR_LEFT:
			$States._change_state("far_left_attack")
		AttackType.LEFT:
			$States._change_state("left_attack")
		AttackType.CENTER:
			$States._change_state("attack")
		AttackType.RIGHT:
			$States._change_state("right_attack")
		AttackType.FAR_RIGHT:
			$States._change_state("far_right_attack")
			
			
func emit_attack_signal():
	match $AnimationPlayer.current_animation:
		"FL_attack":
			emit_signal("attack", AttackType.FAR_LEFT)
		"L_attack":
			emit_signal("attack", AttackType.LEFT)
		"attack":
			emit_signal("attack", AttackType.CENTER)
		"R_attack":
			emit_signal("attack", AttackType.RIGHT)
		"FR_attack":
			emit_signal("attack", AttackType.FAR_RIGHT)


func _ready():
	health_bar.max_value = max_health
	health_bar.value = health
