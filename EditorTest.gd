tool
extends EditorScript

var timer = Timer.new()


func _run():
	print("#####################################")
	var root = get_scene()
	var emma_anim = root.get_node("FightLogic/EmmaSwalowedPosition/Emma/AnimationPlayer")
	emma_anim.play("stand_swallowed", 0)
	var maw_anim = root.get_node("Maw/AnimationPlayer")
	maw_anim.play("stand", 0)
	var camera_anim = root.get_node("Cutscenes/AnimationPlayer")
	camera_anim.play("inside", 0)
	print("#####################################")
