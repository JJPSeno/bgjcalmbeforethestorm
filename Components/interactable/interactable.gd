extends Node

@export var parent : Node2D

func _ready() -> void:
	assert(parent)


func _on_area_entered(area: Area2D) -> void:
	if (parent != null):
		if area.is_in_group("weapon"): 
			if parent.has_method("interact"):
				parent.interact()
			
			for sibling in parent.get_children():
				# this could also hit self, but as long as we dont
				# define _on_interact, should be okay
				if sibling.has_method("_on_interact"):
					sibling._on_interact()
			
		if area.is_in_group("enemy") and parent.has_method("hurt"):
			parent.hurt()
			
