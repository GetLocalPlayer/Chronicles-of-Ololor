extends Area


	
func _on_Area_body_entered(body):
	print("Entered = ", body)


func _on_Area_body_exited(body):
	print("Exited = ", body)
