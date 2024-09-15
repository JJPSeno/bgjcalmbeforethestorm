extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("bloodmoon_started", _on_bloodmoon_started)


func _on_bloodmoon_started() -> void:
	canvas_layer.visible = true
