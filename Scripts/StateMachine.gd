extends Node
class_name StateMachine


var current_state = null


func _ready():
	if get_child_count() > 0:
		current_state = get_child(0).name
		get_child(0)._enter()
	

func _change_state(new_state):
	if current_state != null:
		if has_node(new_state):
			get_node(current_state)._exit()
			current_state = new_state
			get_node(current_state)._enter()
			print(owner.name, " - ", current_state)
	
	
func _physics_process(delta):
	if current_state != null: 
		get_node(current_state)._update(delta)
		var new_state = get_node(current_state)._transition()
		if new_state != null:
			_change_state(new_state)

