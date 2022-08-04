extends GraspState
class_name UpperLeftGraspSuccessState


func _enter():
	anim_player.play("UL_grasp_success", 0)
	

func _transition():
	if ._transition() == "idle":
		return "eat"
