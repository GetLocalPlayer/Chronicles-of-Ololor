extends State

onready var anim_player = owner.get_node("AnimationPlayer")


func _enter():
	anim_player.play("death", 1)
		
	
func _transition():
	if owner.health > 0:
		return "idle"
