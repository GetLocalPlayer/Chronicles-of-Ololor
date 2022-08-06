extends State


onready var anim_player = owner.get_node("AnimationPlayer")
onready var audio = owner.get_node("Sounds/DeathVoice")


func _enter():
	owner.health = 0
	audio.play_random()
	anim_player.play("death", 0.15)
	
	
