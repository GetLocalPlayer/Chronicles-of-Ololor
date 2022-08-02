extends Spatial


signal attack
signal health_changed(new_value)


export (int) var health = 100 setget set_health
export (int) var explosion_damage = 20


enum AttackType {FAR_LEFT, LEFT, CENTER, RIGHT, FAR_RIGHT}


func set_health(new_value: float):
	if new_value < 0:
		new_value = 0
	health = new_value
	emit_signal("health_changed", new_value)
	

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
