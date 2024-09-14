extends Node2D

@onready var fg:Control = $BG/FG
@onready var health:Health = get_parent()

func _process(delta: float) -> void:
	fg.scale = Vector2(health.health/health.max_health,1)
