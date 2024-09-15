extends Node

signal weapon_is_upgraded

var is_weapon_upgraded := false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func upgrade_weapon() -> void:
	is_weapon_upgraded = true
	weapon_is_upgraded.emit()
