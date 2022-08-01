tool
extends EditorScript

var timer = Timer.new()


func _run():
	print("#####################################")
	var root = get_scene()
	var boss = root.get_node("Nhizi")
	var anim_player = boss.get_node("AnimationPlayer")
	anim_player.play("stand", 0)
	print("#####################################")
