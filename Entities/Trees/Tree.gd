extends Node2D

var harvestible:= false
@onready var audio:AudioStreamPlayer = %WoodChop
func _ready() -> void:
	QuestSystem.start_carpenter_quest_1.connect(func ():harvestible = true)
	QuestSystem.finish_carpenter_quest_1.connect(func ():harvestible = false)


func interact():
	audio.play()
	if harvestible:
		QuestSystem.harvested_trees += 1
		hide()
		await audio.finished
		queue_free()
