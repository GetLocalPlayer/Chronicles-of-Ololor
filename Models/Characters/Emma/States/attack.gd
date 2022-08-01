extends State


onready var gravity = owner.gravity
onready var kick_speed = owner.kick_speed
onready var anim_player = owner.get_node("AnimationPlayer")
onready var ray = owner.get_node("Skeleton/RayCast")
onready var audio_barrel_sliding = owner.get_node("Sounds/BarrelSliding")


onready var hit_effect = [
	preload("res://Models/Effects/Hit/Hit_1.tscn"),
	preload("res://Models/Effects/Hit/Hit_2.tscn"),
	preload("res://Models/Effects/Hit/Hit_3.tscn"),
]


var animations = ["attack", "attack_2", "attack_3", "attack_4"]


func _ready():
	randomize()
	ray.add_exception(owner)
	

func on_attack():
	if ray.is_colliding():
		var body = ray.get_collider()
		if body.is_in_group("pushable"):
			var kick_dir = Vector3(0, 0, -ray.get_collision_normal().z)
			body.kick(kick_dir.normalized() * kick_speed)
			var random = randi() % hit_effect.size()
			var instance = hit_effect[random].instance()
			ray.add_child(instance)
			instance.set_as_toplevel(true)
			instance.to_local(ray.get_collision_point())
			instance.translate(instance.to_local(ray.get_collision_point()))
			instance.get_node("AnimationPlayer").play("birth&queue_free")
			audio_barrel_sliding.play_random()
	
	
func _enter():
	var i = randi() % animations.size()
	anim_player.play(animations[i], 0.15)
	owner.connect("attack", self, "on_attack")
	
	
func _update(_delta):
	var gravity = owner.gravity
	var velocity = Vector3(0, -gravity, 0)
	owner.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition(_delta):
	if not anim_player.is_playing():
		return "idle"
	if not owner.is_on_floor():
		return "falling"
	if Input.is_action_just_pressed("jump"):
		return "jump"
	if Input.is_action_pressed("run_left") or Input.is_action_pressed("run_right"):
		if Input.is_action_pressed("crawling"):
			return "crawling"
		else:
			return "run"
	if Input.is_action_pressed("crawling"):
		return "kneel"
	

func _exit(_delta):
	owner.disconnect("attack", self, "on_attack")
