extends Node2D

signal toolsmith_quest_1_ended

var harvestable = false
var harvested = false

@onready var ore_hit:AudioStreamPlayer = $OreHit

func _ready() -> void:
	assert(AudioStreamPlayer)
	QuestSystem.connect("start_toolsmith_quest_1", _on_quest_toolsmith_quest_1_started)
	QuestSystem.connect("finish_toolsmith_quest_1", _on_quest_toolsmith_quest_1_finished)


func interact():
	if harvested: return
	
	ore_hit.play()
	if harvestable:
		harvested = true
		QuestSystem.harvested_ores += 1
		
		## HACK -  cant free until sound is done
		## so we hide, move it far away so the rigidbody is gone
		## then free it
		$OreStaticBody.queue_free()
		hide()
		await ore_hit.finished
		queue_free()


func _on_quest_toolsmith_quest_1_started():
	harvestable = true


func _on_quest_toolsmith_quest_1_finished():
	harvestable = false
