extends Node


# If the boss hp <= 66%, decrease attack
# interval by 33%.
# The boss has a 25% chance to perform bottom
# graps instead of an attack.
# At hp <= 33% the boss stats using normal
# attack only with a 25% chance.

export (float) var explosion_damage = 13
export (float) var attack_interval = 3

onready var boss = owner.get_node("Nhizi")
onready var attack_timer = Timer.new()
onready var player = owner.get_node("Emma")
onready var env = owner.get_node("WorldEnvironment").environment


func _ready():
	randomize()
	add_child(attack_timer)
	attack_timer.connect("timeout", self, "on_attack_timer_expired")
	attack_timer.one_shot = true
	attack_timer.start(attack_interval)
	boss.get_node("States").connect("state_changed", self, "on_boss_state_changed")


func on_boss_state_changed(_old_state, new_state):
	if new_state == "idle":
		var wait_time = attack_interval
		if boss.health/boss.max_health <= 0.666666:
			wait_time *= 0.66666666
		attack_timer.start(wait_time)


func on_attack_timer_expired():
	if not (boss.is_alive() and player.is_alive()):
		return
	if $DownArea.overlaps_body(player):		
		var attack_grasp: Array
		if boss.health/boss.max_health <= 0.3333333:
			attack_grasp = [$BossAttacks, $BossGrasp, $BossGrasp, $BossGrasp]
		else:
			attack_grasp = [$BossAttacks, $BossAttacks, $BossAttacks, $BossGrasp]
		var random = attack_grasp[randi() % attack_grasp.size()]
		random.do()
	else:
		$BossGrasp.do()


func _on_Emma_States_state_changed(_old_state, new_state):
	if new_state == "death":
		$Menu.show()
		$FightMusic.stop()
		$DefeatMusic.play()
		$GrayScreenShader.show()
		


func _on_NhiziFight_ready():
	$StartingSplash/AnimationPlayer.play("start")
	$FightMusic.play()


func _on_BossStates_state_changed(_old_state, new_state):
	if new_state == "death":
		$Key.show()
		$FightMusic.stop()
		$VictoryMusic.play()
		$VictorySplash/AnimationPlayer.play("start")
		owner.get_node("Camera").target = $Key
		player.health_bar.hide()
		boss.health_bar.hide()


func _on_VictoryMusic_finished():
	owner.get_node("Camera").target = player.get_node("CameraFocus")


func _on_Key_body_entered(body):
	if $Key.visible:
		$Key.disconnect("body_entered", self, "_on_Key_body_entered")
		$Key/AnimationPlayer.play("death", 0)
		$KeyTakenMusic.play()
		

func _on_KeyTakenMusic_finished():
	get_tree().change_scene("res://EndOfDemo.tscn")
