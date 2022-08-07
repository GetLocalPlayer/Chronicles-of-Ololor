extends Pushable


# I should make a state machine for this.
# Meh...

signal detonated


onready var anim_player = get_node("AnimationPlayer")


func detonate():
	anim_player.play("death")
	set_physics_process(false)
	emit_signal("detonated")


func detonate_and_queue_free():
	anim_player.play("death&queue_free")
	set_physics_process(false)
	emit_signal("detonated")
	
