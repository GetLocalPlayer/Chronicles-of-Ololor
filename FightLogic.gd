extends Node


export (float) var attack_interval = 4

onready var boss = owner.get_node("Nhizi")
onready var attack_timer = Timer.new()
onready var player = owner.get_node("Emma")

onready var attack_areas = {
	get_node("AreaFL"): boss.AttackType.FAR_LEFT,
	get_node("AreaL"): 	boss.AttackType.LEFT,
	get_node("AreaC"): 	boss.AttackType.CENTER,
	get_node("AreaR"): 	boss.AttackType.RIGHT,
	get_node("AreaFR"): boss.AttackType.FAR_RIGHT,
}


var current_attack_area: int = 0


func _ready():
	add_child(attack_timer)
	attack_timer.one_shot = true
	for area in attack_areas:
		area.connect("body_entered", self, "on_attack_area_entered", [area])
	attack_timer.connect("timeout", self, "on_attack_timer_expired")
	attack_timer.start(attack_interval)


func on_attack_area_entered(body, area):
	if body == player:
		current_attack_area = attack_areas[area]
		

func on_attack_timer_expired():
	boss.attack(current_attack_area)
	attack_timer.start(attack_interval)
	
