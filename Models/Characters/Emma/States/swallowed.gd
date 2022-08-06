extends State


onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("swallowed", 0)

