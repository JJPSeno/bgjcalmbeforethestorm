extends Node

var current_dialogue: Dialogueable
var current_target:Node2D

var _player:Node2D
func _ready() -> void:
	set_process(false)

func set_current_dialogue(diag:Dialogueable):
	if diag == null:
		set_process(false)
		diag = null
		return
		
	# This code snippet ensures only 1 dialogue is active
	# At a time
	if current_dialogue != null:
		current_dialogue.unload()
		
	current_dialogue = diag
	current_target = diag.entity
	set_process(true)

func _process(delta: float) -> void:
	"""
	This system checks if a player walks away
	from the node
	"""
	if !_player:
		_player = get_tree().get_nodes_in_group("player")[0]
	var dist_sqr = _player.global_position\
		.distance_squared_to(current_target.global_position)
	if dist_sqr >= 2800:
		
		"""
		The code below checks if this is the "last" conversation
		in the bubble. In which case - walking away is the same as
		Completing it
		"""
		if current_dialogue and \
			current_dialogue.current_diag and \
			not(current_dialogue.current_diag.next()):
			current_dialogue.current_diag.diag.on_convo_complete()
		current_dialogue.unload()
		current_dialogue = null
		set_process(false)
