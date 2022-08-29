extends Node


export (float) var boss_hit_damage = 10
export (float) var explosion_damage = 13
export (float) var fire_lifetime = 7
export (float) var burning_duration = 10
export (float) var burning_damage_interval = 1
export (float) var burning_damage = 2

onready var boss = owner.get_node("Nhizi")
onready var player = owner.get_node("Emma")
onready var fire = preload("res://Models/Effects/Fire/Fire.tscn")
onready var hit_screen = owner.find_node("HitScreen")


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
			boss.health = boss.health - explosion_damage
			if area.overlaps_body(player) and player.is_alive():
				player.health -= explosion_damage
			body.detonate_and_queue_free()
			var instance = fire.instance()
			owner.add_child(instance)
			instance.global_transform.origin = body.global_transform.origin
			instance.get_node("Area").connect("body_entered", self, "on_fire_entered")
			instance.get_node("Area").connect("body_exited", self, "on_fire_exited")
			var timer = Timer.new()
			instance.add_child(timer)
			timer.one_shot = true
			timer.connect("timeout", self, "on_fire_timer_expired", [instance])
			timer.start(fire_lifetime)
		if body == player and body.is_alive():
			body.health -= boss_hit_damage
			hit_screen.play("fade", 0)
			if body.is_alive():
				body.get_node("Sounds/OhVoice").play_random()
				body.stun()
				


func on_fire_timer_expired(instance):
	instance.queue_free()
	
	
func on_fire_entered(body):
	if body == player and player.is_alive() and player.get_node("States").current_state!= "idle_swallowed":
		player.get_node("BurningTimer").run(burning_damage_interval,  burning_damage, 9999999)
		
		
func on_fire_exited(body):
	if body == player:
		player.get_node("BurningTimer").run(burning_damage_interval,  burning_damage, burning_duration)
