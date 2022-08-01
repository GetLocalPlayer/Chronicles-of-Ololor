extends Pushable

signal detonated(affected_bodies)


onready var anim_player = get_node("AnimationPlayer")
onready var area = get_node("ExplosionArea")


func detonate():
	anim_player.play("death")
	emit_signal("detonated", area.get_overlapping_bodies)
