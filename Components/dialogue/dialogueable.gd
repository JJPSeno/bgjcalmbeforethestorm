extends Node2D

class_name Dialogueable

@export var dialogues:Array[GameDialogue]
@onready var label = $Label

var current_diag:GameDialogueCursor
@onready var entity:Node:
	get: return get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unload()
	
func run_dialogue_selection():
	"""
	Loop through all the dialogues.
	Find the one that returns true first based of 
	the condition
	"""
	for dialogue in dialogues:
		var is_dia_visible = dialogue.evaluate_visibility()
		if is_dia_visible:
			current_diag = GameDialogueCursor.new(dialogue)
			current_diag
			return
	assert(false, "%s has a dialogue behavior that couldnt find a dialogue" % get_parent().name)
	return null
	
func unload():
	label.hide()
	current_diag = null
	
func _on_interact():
	# Inform the system we are changing dialogues
	if DialogueSystem.current_dialogue != self:
		DialogueSystem.set_current_dialogue(self)
	
	"""
	If there's no dialogue, pick a dialogue from the list.
	Then go to the next string - 
	If succesful, display it, else remove the dialogue since its done
	"""
	if current_diag == null:
		run_dialogue_selection()
	if not current_diag.next():
		current_diag.diag.on_convo_complete()
		unload()
		return
	label.text = current_diag.text
	label.show()

class GameDialogueCursor:
	extends RefCounted
	var diag:GameDialogue
	var size:int = 0
	var remaining:int = 0
	var text:String = &""
	func _init(diag:GameDialogue) -> void:
		self.diag = diag
		diag.setup()
		size = diag.parsed_texts.size()
		remaining = size
		
	## Returns true if the text was updated
	## Else false (meaning its done)
	func next() -> bool:
		var index = size - remaining
		remaining -= 1
		
		if index >= size:
			text = &""
			return false
		text = diag.parsed_texts[index]
		return true
