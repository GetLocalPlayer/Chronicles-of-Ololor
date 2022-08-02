extends Node


export (float) var attack_interval = 4

onready var boss = owner.get_node("Nhizi")
onready var attack_timer = Timer.new()
onready var player = owner.get_node("Emma")

onready var area_to_attack_type = {
	get_node("AreaFL"): boss.AttackType.FAR_LEFT,
	get_node("AreaL"): 	boss.AttackType.LEFT,
	get_node("AreaC"): 	boss.AttackType.CENTER,
	get_node("AreaR"): 	boss.AttackType.RIGHT,
	get_node("AreaFR"): boss.AttackType.FAR_RIGHT,
}

var attack_type_to_area = {}
var attack_areas_stack = []
var last_attack_area: Area


func _ready():
	add_child(attack_timer)
	attack_timer.connect("timeout", self, "on_attack_timer_expired")
	attack_timer.start(attack_interval)
	attack_timer.one_shot = true
	for area in area_to_attack_type:
		area.connect("body_entered", self, "on_attack_area_entered", [area])
		area.connect("body_exited", self, "on_attack_area_exited", [area])
		attack_type_to_area[area_to_attack_type[area]] = area
	boss.connect("attack", self, "on_boss_attack")


func on_attack_timer_expired():
	if boss.health <= 0:
		return
	if last_attack_area != null:
		boss.attack(area_to_attack_type[last_attack_area])
	attack_timer.start(attack_interval)
	
	
func on_attack_area_entered(body, area):
	if body == player:
		attack_areas_stack.push_back(area)
		last_attack_area = area


func on_attack_area_exited(body, area):
	if body == player:
		attack_areas_stack.erase(area)
		if attack_areas_stack.size() > 0:
			last_attack_area = attack_areas_stack.back()
		

func on_boss_attack(attack_type):
	var area = attack_type_to_area[attack_type]
	for body in area.get_overlapping_bodies():
		if body.is_in_group("explosive") and body.is_on_floor():
			body.detonate()
			boss.health = boss.health - boss.explosion_damage
