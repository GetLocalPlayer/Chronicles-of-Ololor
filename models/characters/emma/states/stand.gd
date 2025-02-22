extends "idle.gd"


export (float) var time_to_idle = 10
onready var timer = Timer.new()


func _ready():
	add_child(timer)
	timer.one_shot = true
	timer.connect("timeout", self, "start_idle_anim")
			
	
func start_idle_anim():
	anim_player.play("stand_2", 0.75, 0.5)


func _enter():
	var naked = true
	for child in owner.get_node("Skeleton").get_children():
		if child.name.begins_with("Cloth"):
			naked = naked and not child.visible
	if owner.health/owner.max_health <= 0.35:
		anim_player.play("stand_lowhp", 0.1)
	elif naked:
		anim_player.play("stand_nude", 0.1)
	else:
		anim_player.play("stand", 0.1)
		timer.start(time_to_idle)
	
	
func _exit():
	timer.stop()
	
	
func _transition():
	var new_state = ._transition()
	if new_state == null:
		if Input.is_action_pressed("crawling"):
			return "kneel"
		if Input.is_action_just_pressed("attack"):
			return "attack"
	return new_state
