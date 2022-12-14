extends KinematicBody


signal attack
signal state_changed(old_state, new_state)

export (float) var health = 100 setget set_health
export (float) var max_health = 100
export (float) var run_speed = 10
export (float) var crawling_speed = 5
export (float) var slide_speed = 10
export (float) var push_speed = 4
export (float) var wall_sliding_speed = 2
export (float) var gravity = 5
export (float) var jump_speed = 50
export (float) var kick_speed = 10
# To check if second jump is possible
var double_jump_available = true

onready var health_bar = get_node("HealthBar")


func is_alive() -> bool:
	return health > 0
	

func set_health(new_health):
	if new_health < 0:
		health = 0
	elif new_health > max_health:
		health = max_health
	else:
		health = new_health
	health_bar.value = health
	if health == 0 and $States.current_state != "death":
		$States._change_state("death")
	
	
func stun():
	$States._change_state("stun")
	
	
func set_state(new_state: String):
	$States._change_state(new_state)
	
	
func _ready():
	randomize()
	health_bar.value = health
	health_bar.max_value = max_health
	# Random dress
	var hairs = []
	var clothes = []
	for child in $Skeleton.get_children():
		if child.name.begins_with("Hair"):
			hairs.append(child)
			child.hide()
		if child.name.begins_with("Cloth"):
			clothes.append(child)
			child.hide()
	var random = randi() % (hairs.size())
	hairs[random].show()
	random = randi() % (clothes.size() + 1)
	if random < clothes.size():
		clothes[random].show()


func _on_States_state_changed(old_state, new_state):
	emit_signal("state_changed", old_state, new_state)
