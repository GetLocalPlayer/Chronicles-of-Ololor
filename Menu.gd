extends VBoxContainer



func _on_QuitGame_pressed():
	get_tree().quit()


func _on_Retry_pressed():
	get_tree().reload_current_scene()
