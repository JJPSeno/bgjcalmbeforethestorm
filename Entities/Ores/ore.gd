extends Node2D

signal toolsmith_quest_1_ended

var harvestable = false

@onready var ore_hit:AudioStreamPlayer = $OreHit

func _ready() -> void:
	assert(AudioStreamPlayer)
	QuestSystem.connect("start_toolsmith_quest_1", _on_quest_toolsmith_quest_1_started)
	QuestSystem.connect("finish_toolsmith_quest_1", _on_quest_toolsmith_quest_1_finished)


func interact():
	ore_hit.play()
	if harvestable:
		QuestSystem.harvested_ores += 1
		if QuestSystem.harvested_ores >= QuestSystem.ORES_TO_HARVEST:
			QuestSystem.finish_toolsmith_quest_1.emit()
		
		# HACK -  cant free until sound is done
		# so we hide, move it far away so the rigidbody is gone
		# then free it
		hide()
		position = Vector2.INF 
		await ore_hit.finished
		queue_free()


func _on_quest_toolsmith_quest_1_started():
	harvestable = true


func _on_quest_toolsmith_quest_1_finished():
	harvestable = false
