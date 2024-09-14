extends Node2D

@export_group("wires")
@export var animPlayer:AnimationPlayer
@export var flipTarget:Node2D

var animations = [
	"swing_1",
	"swing_2"
]
var anim_index = 0
@onready var sound = $Sound
func _on_interact():
	sound.play()
	anim_index += 1
	var animation_name = animations[ anim_index % animations.size() ]
	animPlayer.play(animation_name)
