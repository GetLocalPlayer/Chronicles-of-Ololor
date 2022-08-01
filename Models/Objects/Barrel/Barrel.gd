extends Pushable

signal detonated(affected_bodies)


onready var anim_player = owner.get_node("AnimationPlayer")
onready var area = owner.get_node("ExplosionAre")


func detonate():
	anim_player.play("death")
	emit_signal("detonated", area.get_overlapping_bodies)
