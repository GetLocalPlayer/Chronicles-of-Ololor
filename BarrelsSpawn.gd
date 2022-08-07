extends Spatial


export (float) var spawn_cooldown = 7

onready var spawn_points = [$Left, $Right]
onready var spawn_timer = Timer.new()

var barrel = preload("res://Models/Objects/Barrel/Barrel.tscn")


func _ready():
	randomize()
	add_child(spawn_timer)
	spawn_timer.connect("timeout", self, "on_spawn_timer_expired")
	spawn_timer.one_shot = true
	spawn_timer.wait_time = spawn_cooldown
	on_spawn_timer_expired()
	

func on_spawn_timer_expired():
	var point = spawn_points[randi() % spawn_points.size()]
	var instance = barrel.instance()
	point.add_child(instance)
	instance.get_node("AnimationPlayer").play("stand")
	instance.connect("detonated", self, "on_barrel_detonated", [instance])
	
	
func on_barrel_detonated(instance):
	spawn_timer.start()
