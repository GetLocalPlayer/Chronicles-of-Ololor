extends Node


onready var player = owner.get_node("Emma")
onready var boss = owner.get_node("Nhizi")
onready var area = $DownGraspArea


func _ready():
	boss.connect("grasp_started", self, "on_grasp_started")
	boss.connect("grasp_ended", self, "on_grasp_ended")
	area.connect("body_entered", self, "on_area_entered")
	area.collision_layer = 0
	area.collision_mask = 0
	
	
func on_grasp_started():
	area.collision_layer = 1
	area.collision_mask = 1
	
	
func on_grasp_ended():
	area.collision_layer = 0
	area.collision_mask = 0
	
	
func on_area_entered(body):
	if body == player:
		print("-------------- CAUGHT")


func do():
	boss.get_node("States")._change_state("grasp")
