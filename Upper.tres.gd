extends Node


onready var boss = owner.get_node("Nhizi")
onready var player = owner.get_node("Emma")
onready var cutscenes = owner.get_node("Cutscenes")
onready var upper_left_area = $AreaUL
onready var upper_right_area = $AreaUR
onready var area_to_state = {
	upper_left_area: "upper_left_grasp",
	upper_right_area: "upper_right_grasp"
}
onready var grasp_center_position = get_parent().get_node("GraspCenterPosition").global_transform.origin


func do():
	if grasp_center_position.z < player.global_transform.origin.z:
		boss.get_node("States")._change_state(area_to_state[upper_left_area])
	else:
		boss.get_node("States")._change_state(area_to_state[upper_right_area])
	
	
func _ready():
	boss.connect("upper_left_grasp", self, "on_upper_left_grasp")
	boss.connect("upper_right_grasp", self, "on_upper_right_grasp")
	

func on_upper_left_grasp():
	if upper_left_area.overlaps_body(player) and player.is_alive():
		boss.get_node("States")._change_state("upper_left_grasp_success")
		cutscenes.get_node("Camera").make_current()
		var anim_player = cutscenes.get_node("AnimationPlayer")
		anim_player.play("L_grasp", 0)
		anim_player.queue("swallow")
		player.get_node("Sounds/OhVoice").play_random()
		

func on_upper_right_grasp():
	if upper_right_area.overlaps_body(player) and player.is_alive():
		boss.get_node("States")._change_state("upper_right_grasp_success")
		cutscenes.get_node("Camera").make_current()
		var anim_player = cutscenes.get_node("AnimationPlayer")
		anim_player.play("R_grasp", 0)
		anim_player.queue("swallow")
		player.get_node("Sounds/OhVoice").play_random()






