extends StaticBody


var fire = preload("res://Models/Effects/Fire/Fire.tscn")


func _physics_process(_delta):
	for body in get_tree().get_nodes_in_group("explosive"):
		for i in body.get_slide_count():
			var collision = body.get_slide_collision(i)
			if collision.collider == self:
				body.detonate_and_queue_free()
	for body in get_tree().get_nodes_in_group("player"):
		if not body.is_alive():
			continue
		for i in body.get_slide_count():
			var collision = body.get_slide_collision(i)
			if collision.collider == self:
				body.health = 0
				body.translation = collision.position
				var instance = fire.instance()
				owner.add_child(instance)
				instance.translation = collision.position
				instance.get_node("AnimationPlayer").play("birth")
