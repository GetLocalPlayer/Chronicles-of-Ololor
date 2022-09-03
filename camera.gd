extends Camera


export (float) var look_at_delay = 0.25
export (float) var shake_amplitude = 0.5 # max h/v offset during shaking
onready var target = owner.get_node("Emma/CameraFocus")


func _ready():
	rotation = Vector3.ZERO
	
	
func _process(delta):
	var look_at_transform = global_transform.looking_at(target.global_transform.origin, Vector3.UP)
	var new_transform = global_transform.interpolate_with(look_at_transform, delta/look_at_delay)
	global_transform = new_transform



func _on_ShakeOverTimer_timeout():
	$ShakeTimer.stop()
	$Tween.interpolate_property(self, "h_offset", h_offset, 0, $ShakeTimer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "v_offset", v_offset, 0, $ShakeTimer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_ShakeTimer_timeout():
	var rand_h = rand_range(-shake_amplitude, shake_amplitude)
	var rand_v = rand_range(-shake_amplitude, shake_amplitude)
	
	$Tween.interpolate_property(self, "h_offset", h_offset, rand_h, $ShakeTimer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "v_offset", v_offset, rand_v, $ShakeTimer.wait_time, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Nhizi_attack(_attack_type):
	$ShakeTimer.start()
	$ShakeOverTimer.start()
