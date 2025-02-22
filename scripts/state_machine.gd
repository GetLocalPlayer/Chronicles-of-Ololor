extends Node
class_name StateMachine


signal state_changed(old_state, new_state)


var current_state = null


func _ready():
	if get_child_count() > 0:
		_change_state(get_child(0).name)
	
	
func _change_state(new_state):
	assert(new_state != null, "New state can't be \"null\"")
	assert(has_node(new_state), "There's no state \"%s\"" % new_state)
	if current_state != null:
		get_node(current_state)._exit()
	var old_state = current_state
	current_state = new_state
	get_node(current_state)._enter()
	emit_signal("state_changed", old_state, new_state)
	#print(owner.name, " - ", current_state)
	
	
func _transition():
	var new_state = get_node(current_state)._transition()
	if new_state != null:
		_change_state(new_state)
		

func _unhandled_input(event):
	get_node(current_state)._handle_input(event)
	
	
func _physics_process(delta):
	if current_state != null: 
		get_node(current_state)._update(delta)
		_transition()

