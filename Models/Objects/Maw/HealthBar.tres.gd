extends TextureProgress


export (int) var decrease_per_second = 5
export (int) var decrease_interwal = 0.1
export (float) var desirable_ratio = 1

onready var default_size = rect_size
onready var timer = Timer.new()


func _ready():
	add_child(timer)
	timer.one_shot = false
	timer.wait_time = decrease_interwal
	timer.connect("timeout", self, "on_timer_expired")
	if get_node("/root").get_child(0) == owner:
		timer.start()

	
func on_timer_expired():
	value -= timer.wait_time * decrease_per_second
	
		
func _process(_delta):
	var parent_size = get_viewport().size
	var scale = parent_size.y / default_size.y
	if scale < desirable_ratio:
		rect_scale.x = scale * desirable_ratio
		rect_scale.y = scale * desirable_ratio
	else:
		rect_scale.x = desirable_ratio
		rect_scale.y = desirable_ratio


func _on_HealthBar_visibility_changed():
	if visible:
		timer.start()
		value = max_value/2
	else:
		timer.stop()
		
