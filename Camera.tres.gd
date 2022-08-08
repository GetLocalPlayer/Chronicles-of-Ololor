extends Camera


export (float) var look_at_delay = 0.25


func _process(delta):
	var player = owner.get_node("Emma")
	if player.is_alive():
		var target = player.get_node("CameraFocus")
		var look_at_transform = global_transform.looking_at(target.global_transform.origin, Vector3.UP)
		var new_transform = global_transform.interpolate_with(look_at_transform, delta/look_at_delay)
		global_transform = new_transform



