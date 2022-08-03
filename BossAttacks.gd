extends Node


export (float) var explosion_damage = 13

onready var boss = owner.get_node("Nhizi")
onready var player = owner.get_node("Emma")


onready var area_to_state = {
	get_node("AreaFL"): "far_left_attack",
	get_node("AreaL"):	"left_attack",
	get_node("AreaC"): 	"attack",
	get_node("AreaR"): 	"right_attack",
	get_node("AreaFR"): "far_right_attack",
}

onready var attack_type_to_area = {
	boss.AttackType.FAR_LEFT: get_node("AreaFL"),
	boss.AttackType.LEFT: get_node("AreaL"),
	boss.AttackType.CENTER: get_node("AreaC"),
	boss.AttackType.RIGHT: get_node("AreaR"),
	boss.AttackType.FAR_RIGHT: get_node("AreaFR"),
}

var last_entered_area: Area


func _ready():
	for area in area_to_state:
		area.connect("body_entered", self, "on_attack_area_entered", [area])
	boss.connect("attack", self, "on_boss_attack")
	
	
func do():
	if last_entered_area != null:
		boss.get_node("States")._change_state(area_to_state[last_entered_area])
	
	
func on_attack_area_entered(body, area):
	if body == player:
		last_entered_area = area


func on_boss_attack(attack_type):
	var area = attack_type_to_area[attack_type]
	for body in area.get_overlapping_bodies():
		if body.is_in_group("explosive") and body.is_on_floor():
			body.detonate()
			boss.health = boss.health - explosion_damage
