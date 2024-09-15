extends Node2D


func interact():
	pass


func hurt():
	remove_from_group("zom_target")
	GameManager.get_all_zom_targets()
	visible = false
