tool
extends EditorScript

var timer = Timer.new()


func _run():
	print("#####################################")
	var root = get_scene()
	var anim_player = root.get_node("AnimationPlayer")
	for name in anim_player.get_animation_list():
		print(name)
		anim_player.rename_animation(name, name.trim_prefix("emma_"))
	print("#####################################")
