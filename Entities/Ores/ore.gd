extends Node2D


func interact():
	print("You have interacted with ore")
	
	# Temporary, change this to the actual system
	for child in get_children():
		if child.has_method("_on_interact"):
			child._on_interact()
