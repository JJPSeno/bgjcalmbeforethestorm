extends Resource

class_name GameDialogue

## Example
##  get_quest('plants_cut') >= 4 AND get_quest('meteor') == 'done'
@export_multiline var condition:String

@export_multiline var text:String

## Example
##  set_quest('plants_cut', true) AND set_quest(
@export_multiline var completion:String
var parsed_texts:PackedStringArray
func setup():
	var strs = []
	for str in text.split("---"):
		strs.append(str.strip_edges())
	parsed_texts = strs

func evaluate_visibility():
	return evalute_script(condition)

func on_convo_complete():
	if completion:
		evalute_script(completion)
	
func evalute_script(script:String):
	if not script:
		return true
	var expression = Expression.new()
	expression.parse(script)

	return expression.execute([], self)
	
func get_quest(str:String, default=null):
	return QuestSystem.quest_vars.get(str, default)
	
func set_quest(str:String, value):
	QuestSystem.quest_vars[str] = value
	return true

func start_quest(job: String, level: String) -> bool:
	QuestSystem.emit_signal("start_"+job+"_quest_"+level)
	QuestSystem.is_questing = true
	QuestSystem.current_quest_giver = job
	return true


func check_quest_toolsmith_1() -> bool:
	return (QuestSystem.is_questing == false) && (QuestSystem.toolsmith_level == 1)


func check_is_questing(job: String) -> bool:
	return (QuestSystem.is_questing == true) && (QuestSystem.current_quest_giver == job)
