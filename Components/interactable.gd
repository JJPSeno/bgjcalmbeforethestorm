extends Node

@export var parent : Node2D


func _on_area_entered(area: Area2D) -> void:
	print("_on_area_entered entered")
	if (parent != null) and parent.has_method("interact") and area.is_in_group("weapon"):
		parent.interact()
