extends VBoxContainer



func _on_QuitGame_pressed():
	get_tree().quit()


func _on_Retry_pressed():
	get_tree().reload_current_scene()


func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		if not visible:
			$Retry.hide()
			show()
			get_tree().paused = true
		elif get_tree().paused:
			$Retry.show()
			hide()
			get_tree().paused = false
