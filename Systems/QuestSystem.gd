extends Node

var is_questing := false
var quest_vars = {}

#region toolsmith quest block
#region toolsmith quest 1
var toolsmith_level = 1
signal start_toolsmith_quest_1
signal finish_toolsmith_quest_1

const ORES_TO_HARVEST := 3
var harvested_ores = 0

# all state changes will be handled by ore.gd
func exec_finish_toolsmith_quest_1():
	finish_toolsmith_quest_1.emit()
#endregion

signal start_toolsmith_quest_2
signal finish_toolsmith_quest_2

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
