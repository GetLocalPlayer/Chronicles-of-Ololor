extends Timer


# This should be an effect with some
# effect manager. But since we have
# only like 2 effects for the whole 
# game, unique for the only character,
# let's bake it in the character.

var interval: float
var damage: float
var remaining: float
	
	
func run(_interval: float, _damage: float, _duration: float):
	interval = _interval
	damage = _damage
	remaining = _duration
	if not $Burning.visible:
		start(interval)
		$Burning.show()
		
		
func cancel():
	$Burning.hide()
	stop()
	
	

func on_expired():
	if owner.is_alive():
		if remaining >= interval:
			owner.health -= damage
	remaining -= interval
	if remaining > 0:
		start(interval)
	else:
		$Burning.hide()
		
		
func _ready():
	one_shot = true
	connect("timeout", self, "on_expired")
	owner.get_node("States").connect("state_changed", self, "on_state_changed")

