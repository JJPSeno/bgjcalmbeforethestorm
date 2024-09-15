extends Node2D

var is_harvestible:bool = false
@onready var audio:AudioStreamPlayer = %HitSound

func _ready() -> void:
	QuestSystem.start_toolsmith_quest_2.connect(_on_quest_start)

func _on_quest_start():
	is_harvestible = true

func interact():
	audio.play(0.1)
	if is_harvestible:
		QuestSystem.has_meteor = true
		var meteor = $Meteor
		meteor.hide()
		meteor.position = Vector2.INF
		await audio.finished
		queue_free()
		
