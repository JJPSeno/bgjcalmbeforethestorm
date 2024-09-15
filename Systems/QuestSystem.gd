extends Node

## Should only do 1 quest at a time
var is_questing := false
var active_quest:String

func start_quest(job: String, level: int) -> bool:
	active_quest = "%s_%s" % [job,level]
	var sign_name = "start_%s_quest_%s" % [job,level]
	emit_signal(sign_name)
	return true
	
func finish_quest(job: String, level: int) -> bool:
	active_quest = ""
	var sign_name = "finish_%s_quest_%s" % [job,level]
	emit_signal(sign_name)
	return true


#region toolsmith quest block
signal start_toolsmith_quest_1
signal finish_toolsmith_quest_1

signal start_toolsmith_quest_2
signal finish_toolsmith_quest_2

const ORES_TO_HARVEST := 3

var toolsmith_level = 1
var harvested_ores = 0
var has_meteor = false
#endregion





#region tailor quest block
var tailor_level = 1
signal start_tailor_quest_1
signal finish_tailor_quest_1

signal start_tailor_quest_2
signal finish_tailor_quest_2
#endregion

#region carpenter quest block
var carpenter_level = 1
signal start_carpenter_quest_1
signal finish_carpenter_quest_1

signal start_carpenter_quest_2
signal finish_carpenter_quest_2
#endregion
