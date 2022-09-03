extends Node


onready var cutscenes = owner.get_node("Cutscenes")
onready var player = owner.get_node("Emma")
onready var boss = owner.get_node("Nhizi")
onready var area = $DownGraspArea
onready var grasp_center_position = get_parent().get_node("GraspCenterPosition").global_transform.origin


func do():
	boss.get_node("States")._change_state("grasp")
	

func _ready():
	area.collision_layer = 0
	area.collision_mask = 0
	
	
func _on_Nhizi_grasp_started():
	area.collision_layer = 1
	area.collision_mask = 1

	
func _on_Nhizi_grasp_ended():
	area.collision_layer = 0
	area.collision_mask = 0
	

func _on_DownGraspArea_body_entered(body):
	if body == player and player.is_alive():
		area.collision_layer = 0
		area.collision_mask = 0
		cutscenes.get_node("Camera").make_current()
		cutscenes.get_node("AnimationPlayer").play("R_grasp", 0)
		if grasp_center_position.z < player.global_transform.origin.z:
			boss.get_node("States")._change_state("left_grasp_success")
		else:
			boss.get_node("States")._change_state("right_grasp_success")
		cutscenes.get_node("AnimationPlayer").queue("swallow")
		player.get_node("Sounds/OhVoice").play_random()
		player.get_node("BurningTimer").cancel()
