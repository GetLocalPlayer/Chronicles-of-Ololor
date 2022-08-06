extends Spatial


signal attack
signal grasp_started # Emmited from the animation player
signal grasp_ended # Emmited from the animation player
signal upper_left_grasp # Emmited from the animation player
signal upper_right_grasp # Emmited from the animation player
signal spitout_frame


export (int) var health = 100
onready var health_bar = get_node("HealthBar")
enum AttackType {FAR_LEFT, LEFT, CENTER, RIGHT, FAR_RIGHT}


func _process(_delta):
	health_bar.value = health
	

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
