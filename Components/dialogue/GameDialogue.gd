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
		for item in completion.split("\n"):
			evalute_script(item)
	
func evalute_script(script:String):
	if not script:
		return true
	var expression = Expression.new()
	var err = expression.parse(script)
	var result = expression.execute([], QuestSystem)
	if expression.has_execute_failed():
		printerr("Dialogue unable to evaluate",expression.get_error_text())
		return false
	return result
