extends State


# You can get out of this state
# only from outside.

onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("eat", 0.1)
	
