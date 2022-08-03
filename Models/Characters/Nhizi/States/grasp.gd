extends State
class_name GraspState


onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("grasp", 0.15)
	
	
func _transition():
	if not anim_player.is_playing():
		if owner.health <= 0:
			return "death"
		return "idle"
	
