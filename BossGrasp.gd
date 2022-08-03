extends Node


onready var player = owner.get_node("Emma")


func do():
	if $DownArea.overlaps_body(player):
		$Lower.do()
	else:
		$Upper.do()
	
