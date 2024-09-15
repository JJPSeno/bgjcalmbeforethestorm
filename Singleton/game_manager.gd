extends Node

signal weapon_is_upgraded
signal bloodmoon_started

var is_weapon_upgraded := false
var zom_targets


func _ready() -> void:
	get_all_zom_targets()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("debug_1"):
		bloodmoon_started.emit()

func upgrade_weapon() -> void:
	is_weapon_upgraded = true
	weapon_is_upgraded.emit()


func get_all_zom_targets() -> void:
	zom_targets = get_tree().get_nodes_in_group("zom_target")


func start_bloodmoon() -> void:
	bloodmoon_started.emit()


func _on_timer_timeout() -> void:
	start_bloodmoon()
