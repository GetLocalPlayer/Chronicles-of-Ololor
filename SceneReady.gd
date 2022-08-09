extends Node


func _ready():
	$StartingSplesh/AnimationPlayer.play("start")
	$AudioStreamPlayer.play()
