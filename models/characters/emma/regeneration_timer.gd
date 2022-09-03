extends Timer


export (float) var interval = 5
export (float) var amount = 5


func _ready():
	wait_time = interval
	one_shot = false
	connect("timeout", self, "on_expired")
	start()
	

func on_expired():
	if owner.is_alive():
		owner.health += amount
