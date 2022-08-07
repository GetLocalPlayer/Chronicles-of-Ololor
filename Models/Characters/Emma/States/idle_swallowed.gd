extends State


onready var anim_player = owner.get_node("AnimationPlayer")
onready var audio = owner.get_node("Sounds/OhVoice")
var saved_collision_layer: int
var saved_collision_mask: int


func _enter():
	owner.get_node("Skeleton").rotation = Vector3(0, 0, 0)
	anim_player.play("stand_swallowed", 0)
	saved_collision_layer = owner.collision_layer
	saved_collision_mask = owner.collision_mask
	owner.collision_layer = 0
	owner.collision_mask = 0
	audio.play_random()
	
	
func _exit():
	owner.collision_layer = saved_collision_layer
	owner.collision_mask = saved_collision_mask
