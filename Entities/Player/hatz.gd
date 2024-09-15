extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestSystem.finish_tailor_quest_1.connect(func ():
		%"Hat 1".show()
		)
		
	QuestSystem.finish_tailor_quest_2.connect(func ():
		%"Hat 2".show()
		)
