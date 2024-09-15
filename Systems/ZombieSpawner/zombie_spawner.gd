extends Marker2D


@onready var zombie = preload("res://Entities/Enemies/Zombie/zombie.tscn")
func _ready() -> void:
	GameManager.connect("bloodmoon_started", _on_bloodmoon_started)


func _on_bloodmoon_started() -> void:
	var zombie_instance = zombie.instantiate()
	zombie_instance.position = position
	get_parent().add_child(zombie_instance)
