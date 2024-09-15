extends Node2D


func interact(area: Area2D):
	print("You have interacted with the tailor")
	
	# Temporary, change this to the actual system
	for child in get_children():
		if child.has_method("_on_interact"):
			child._on_interact()
