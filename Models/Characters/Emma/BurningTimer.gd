extends Timer


# At this point I'm burning out to work
# on this demo. 

export (float) var interval = 1
export (float) var damage = 2
export (float) var duration = 10
var remaining: float

	
func run():
	remaining = duration
	if not $Burning.visible:
		start(interval)
		
		
func cancel():
	$Burning.hide()
	stop()
	
	
func _ready():
	one_shot = true
	connect("timeout", self, "on_expired")
	

func on_expired():
	if owner.is_alive():
		if remaining >= interval:
			owner.health -= damage
	remaining -= interval
	if remaining > 0:
		start(interval)
	else:
		$Burning.hide()
