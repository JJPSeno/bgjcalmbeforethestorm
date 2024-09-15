extends Node2D

var harvestible:= false
@onready var audio:AudioStreamPlayer = %CottonHit
func _ready() -> void:
	QuestSystem.start_tailor_quest_1.connect(func ():harvestible = true)
	QuestSystem.finish_tailor_quest_1.connect(func ():harvestible = false)


func interact():
	audio.play()
	if harvestible:
		QuestSystem.harvested_cotton += 1
		hide()
		await audio.finished
		queue_free()
