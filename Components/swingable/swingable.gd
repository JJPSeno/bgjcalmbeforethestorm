extends Node2D

@export_group("wires")
@export var animPlayer:AnimationPlayer
@export var flipTarget:Node2D

var animations = [
	"swing_1",
	"swing_2"
]
var anim_index = 0

func _on_interact():
	anim_index += 1
	var animation_name = animations[ anim_index % animations.size() ]
	animPlayer.play(animation_name)
