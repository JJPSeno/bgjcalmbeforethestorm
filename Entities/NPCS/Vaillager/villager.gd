extends Node2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	animated_sprite_2d.frame = randi_range(0, 3)


func hurt():
	remove_from_group("zom_target")
	GameManager.get_all_zom_targets()
	visible = false
