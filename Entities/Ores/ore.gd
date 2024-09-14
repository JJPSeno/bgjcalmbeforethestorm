extends Node2D

signal toolsmith_quest_1_ended

var harvestable = false


func _ready() -> void:
	QuestSystem.connect("start_toolsmith_quest_1", _on_quest_toolsmith_quest_1_started)
	QuestSystem.connect("finish_toolsmith_quest_1", _on_quest_toolsmith_quest_1_finished)


func interact():
	if harvestable:
		QuestSystem.harvested_ores += 1
		if QuestSystem.harvested_ores >= QuestSystem.ORES_TO_HARVEST:
			QuestSystem.finish_toolsmith_quest_1.emit()
		queue_free()


func _on_quest_toolsmith_quest_1_started():
	harvestable = true


func _on_quest_toolsmith_quest_1_finished():
	QuestSystem.toolsmith_level = 2
	harvestable = false
