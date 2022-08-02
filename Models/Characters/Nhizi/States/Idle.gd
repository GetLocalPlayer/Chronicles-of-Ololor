extends State


onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("stand", 0.15)	
	
	
func _transition():
	if owner.health <= 0:
		return "death"
	

