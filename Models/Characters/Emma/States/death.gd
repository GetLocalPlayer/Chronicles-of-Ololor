extends State


onready var anim_player = owner.get_node("AnimationPlayer")
onready var audio = owner.get_node("Sounds/DeathVoice")


func _enter():
	audio.play_random()
	
	
