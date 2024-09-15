extends Node2D


var harvestible:= true
@onready var audio = %WoodChop
@onready var spriteBoarded = %"Sprite - Boarded"
@onready var sprite = %"Sprite"
func _ready() -> void:
	QuestSystem.start_carpenter_quest_2.connect(func ():harvestible = true)
	QuestSystem.finish_carpenter_quest_2.connect(func ():harvestible = false)


func interact():
	audio.play()
	if harvestible:
		QuestSystem.windows_upgrade_count -= 1
		spriteBoarded.show()
		sprite.hide()
