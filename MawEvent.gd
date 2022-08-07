extends Node


onready var cutscenes = owner.get_node("Cutscenes")
onready var main_camera = owner.get_node("Camera")
onready var player = owner.get_node("Emma")
onready var boss = owner.get_node("Nhizi")
onready var maw = $Maw
onready var menu = owner.get_node("Menu")


func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name in ["L_grasp", "R_grasp"]:
		player.global_transform.origin = $EmmaMawPosition.global_transform.origin
		player.get_node("States")._change_state("idle_swallowed")
		maw.get_node("AnimationPlayer").play("stand", 0)
	
	
func _on_CutscenesAnimationPlayer_animation_finished(anim_name):
	if anim_name == "swallow":
		boss.health_bar.hide()
		player.health_bar.hide()
		maw.get_node("HealthBar").show()
		cutscenes.get_node("AnimationPlayer").play("inside", 0)
	if anim_name == "spitout":
		main_camera.make_current()


func _on_HealthBar_value_changed(value):
	var health_bar = maw.get_node("HealthBar")
	if value == 0:
		health_bar.hide()
		player.get_node("States")._change_state("swallowed")
		maw.get_node("AnimationPlayer").play("swallow", 0)
		cutscenes.get_node("AnimationPlayer").play("inside_swallowed", 0)
	if value == health_bar.max_value:
		cutscenes.get_node("AnimationPlayer").play("spitout", 0)
		boss.health_bar.show()
		boss.get_node("States")._change_state("spitout")
		player.health_bar.show()
		maw.get_node("HealthBar").hide()


func _on_Maw_AnimationPlayer_animation_finished(anim_name):
	menu.show()


func _on_Nhizi_spitout_frame():
	player.global_transform.origin = $EmmaSpitoutPosition.global_transform.origin
	player.get_node("States")._change_state("stun")
