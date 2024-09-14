extends Node2D

@onready var v_door_sprite: Sprite2D = %"V Door"
@onready var h_door_sprite: Sprite2D = %"H Door"
@onready var sound = %DoorOpen
@onready var body:StaticBody2D = %"SOLID BODY"
@onready var original_mask:int = body.collision_mask
@onready var original_layer:int = body.collision_layer

var is_open := false

func _ready() -> void:
	assert(v_door_sprite)
	assert(h_door_sprite)
	assert(sound)

func _on_interact():
	sound.play()
	var doors = [
		h_door_sprite,
		v_door_sprite,
	]
	doors[ int(is_open) ].hide()	
	doors[ int(!is_open) ].show()	
	
	body.collision_mask = original_mask if is_open else 0
	body.collision_layer = original_layer if is_open else 0
	is_open = not(is_open)
