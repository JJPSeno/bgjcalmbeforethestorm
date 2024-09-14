extends Node2D

@export var target:Node2D
@export var is_bobbing:bool = false:
    get: return is_bobbing
    set(v):
        is_bobbing = v
        if v:
            player.play()
        else:
            player.stop()
            target_scale = Vector2.ONE # reset the size

@export_group("debug")
@export var target_scale:Vector2 = Vector2.ONE
@export var player:AnimationPlayer

func _ready() -> void:
    is_bobbing = is_bobbing # Trigger the setter

func _process(delta: float) -> void:
    #target.scale = snapped(target_scale, Vector2(0.01,0.01))
    target.scale = target_scale.move_toward(target_scale, 0.1)
