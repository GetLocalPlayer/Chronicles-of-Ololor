extends "idle.gd"


onready var kick_speed = owner.kick_speed
onready var ray = owner.get_node("Skeleton/RayCast")
onready var audio = owner.get_node("Sounds/BarrelAttacked")


onready var hit_effect = [
	preload("res://Models/Effects/Hit/Hit_1.tscn"),
	preload("res://Models/Effects/Hit/Hit_2.tscn"),
	preload("res://Models/Effects/Hit/Hit_3.tscn"),
]

onready var test = preload("res://Models/Effects/Fire/Fire.tscn")

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
			owner.add_child(instance)
			instance.set_as_toplevel(true)
			instance.to_local(ray.get_collision_point())
			instance.translate(instance.to_local(ray.get_collision_point()))
			instance.get_node("AnimationPlayer").play("birth&queue_free")
			audio.play_random()
	
	
func _enter():
	var i = randi() % animations.size()
	anim_player.play(animations[i], 0.15)
	owner.connect("attack", self, "on_attack")
	
	
func _update(_delta):
	var gravity = owner.gravity
	var velocity = Vector3(0, -gravity, 0)
	owner.move_and_slide(velocity, Vector3.UP, false, 4, PI/4, false)
	
	
func _transition():
	var new_state = ._transition()
	if new_state == null:
		if not anim_player.is_playing():
			if Input.is_action_pressed("crawling"):
				return "kneel"
			else:
				return "stand"
	return new_state
	

func _exit():
	owner.disconnect("attack", self, "on_attack")
