extends Pushable

signal detonated(area)
signal body_entered_fire(area, body)
signal body_exited_fire(area, body)


onready var anim_player = get_node("AnimationPlayer")
onready var explosion_area = get_node("ExplosionArea")
onready var fire_area = get_node("FireArea")


func detonate():
	anim_player.play("death")
	emit_signal("detonated", explosion_area)
	set_physics_process(false)
	
	fire_area.connect("body_entered", self, "on_fire_area_entered", [fire_area])
	fire_area.connect("body_exited", self, "on_fire_area_exited", [fire_area])
	
	
func on_fire_area_entered(body, area):
	emit_signal("body_entered_fire", area, body)
	
	
func on_fire_area_exited(body, area):
	emit_signal("on_fire_area_exited", area, body)
