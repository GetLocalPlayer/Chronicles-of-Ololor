extends Node
class_name StateMachine


var current_state = null
var states = {}


func _ready():
	if get_child_count() > 0:
		current_state = get_child(0).name
		get_child(0)._enter()
		for child in get_children():
			states[child.name] = child
	
	
func _physics_process(delta):
	if current_state != null: 
		get_node(current_state)._update(delta)
		var new_state = get_node(current_state)._transition(delta)
		if new_state != null:
			if states.has(new_state):
				get_node(current_state)._exit(delta)
				current_state = new_state
				get_node(current_state)._enter()
				print(current_state)
			else:
				pass
				#print("There's no state \"" + new_state + "\"")

