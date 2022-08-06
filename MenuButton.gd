extends TextureButton



func _on_Button_mouse_entered():
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("hover", 0)


func _on_Button_mouse_exited():
	$AnimationPlayer.play("hover", 0, -1, not $AnimationPlayer.is_playing())
