extends Node


export (float) var explosion_damage = 13
export (float) var attack_interval = 4

onready var boss = owner.get_node("Nhizi")
onready var attack_timer = Timer.new()
onready var player = owner.get_node("Emma")
onready var menu = owner.get_node("Menu")


func _ready():
	randomize()
	add_child(attack_timer)
	attack_timer.connect("timeout", self, "on_attack_timer_expired")
	attack_timer.one_shot = true
	attack_timer.start(attack_interval)
	boss.get_node("States").connect("state_changed", self, "on_boss_state_changed")


func on_boss_state_changed(_old_state, new_state):
	if new_state == "idle":
		attack_timer.start(attack_interval)


func on_attack_timer_expired():
	if not (boss.is_alive() and player.is_alive()):
		return
	if $DownArea.overlaps_body(player):
		var attack_grasp = [$BossAttack, $BossGrasp]
		var random = attack_grasp[randi() % attack_grasp.size()]
		random.do()
	else:
		$BossGrasp.do()


func _on_Emma_States_state_changed(_old_state, new_state):
	if new_state == "death":
		menu.show()
		
