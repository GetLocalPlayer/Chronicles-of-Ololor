extends State
class_name AttackState


onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("attack", 0.15)


func _transition():
	if owner.health <= 0:
		return "death"
	if not anim_player.is_playing():
		return "idle"
