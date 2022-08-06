extends KinematicBody


signal attack

export (float) var health = 100 setget set_health
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
		new_health = 0
	health = new_health
	health_bar = new_health
	if health == 0 and $States.current_state != "death":
		$States._change_state("death")
	
	
func _ready():
	health_bar.value = health

