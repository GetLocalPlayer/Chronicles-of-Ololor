extends Spatial


signal attack_far_left
signal attack_left
signal attack
signal attacK_right
signal attack_far_right


export (int) var health = 100
export (int) var explosion_damage = 20


enum AttackType {FAR_LEFT, LEFT, CENTER, RIGHT, FAR_RIGHT}



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
