extends State


onready var anim_player = owner.get_node("AnimationPlayer")
onready var body = owner


var yellow_dust = preload("res://Models/Effects/DustYellow/DustYellow.tscn")


func spawn_yellow_dust():
	var instance = yellow_dust.instance()
	body.add_child(instance)
	instance.set_as_toplevel(true)
	instance.translation = body.translation
	instance.get_node("AnimationPlayer").play("birth&queue_free", -1, 2)


func _enter():
	anim_player.stop()
	spawn_yellow_dust()
	if Input.is_action_pressed("crawling"):
		anim_player.play("landing_crawling")
	else:
		anim_player.play("landing")
		
	
func _transition(_delta):
	if Input.is_action_just_pressed("jump"):
		return"jump"
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		return "run"
	if not anim_player.is_playing():
		return "idle"


