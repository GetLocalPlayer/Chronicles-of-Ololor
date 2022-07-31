extends KinematicBody


export (float) var run_speed = 10
export (float) var crawling_speed = 5
export (float) var slide_speed = 10
export (float) var push_speed = 4
export (float) var wall_sliding_speed = 2.5
export (float) var gravity = 5
export (float) var jump_speed = 50
# To check if second jump is possible
export (bool) var double_jump_available = true


func _ready():
	pass

