extends TextureRect

# Percent of max hp
# keep minimal possible value above 0
# to avoid division by zero
export (float, 1, 100, 1) var hp_threshold = 70


func _process(_delta):
	var hp = owner.health / owner.max_health
	var threshold = hp_threshold / 100.0
	visible = hp < threshold
	modulate.a = 1 - hp / threshold
