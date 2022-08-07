extends Node


onready var player = owner.get_node("Emma")
onready var down_area = get_parent().get_node("DownArea")


func do():
	if down_area.overlaps_body(player):
		$Lower.do()
	else:
		$Upper.do()
	
