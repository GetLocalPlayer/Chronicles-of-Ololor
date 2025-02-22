extends ColorRect


onready var progress_bar = get_node("%ProgressBar")
onready var loader = ResourceLoader.load_interactive("res://fight_scene.tscn")


func _ready():
	progress_bar.value = 0
	

func _process(_delta):
	var result = loader.poll()
	if result == OK:
		progress_bar.value = float(loader.get_stage())/float(loader.get_stage_count())
	elif result == ERR_FILE_EOF:
		progress_bar.value = progress_bar.max_value
		get_tree().change_scene_to(loader.get_resource())
	else:
		print("error during loading, abandon")


