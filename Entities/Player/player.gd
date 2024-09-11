extends CharacterBody2D


var SPEED := 200.0
var acceleration := 12.0
var friction := 15.0
var direction := Vector2.ZERO
var target_velocity := Vector2.ZERO
var current_facing : int
@onready var weapon_pivot: Node2D = $WeaponPivot
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

enum FacingDirection {UP, RIGHT, DOWN, LEFT}


func _ready() -> void:
    current_facing = FacingDirection.DOWN


func _input(event: InputEvent) -> void:
    if event.is_action_pressed("movement"):
        if event.is_action_pressed("up"):
            change_facing(FacingDirection.UP)
        elif event.is_action_pressed("right"):
            change_facing(FacingDirection.RIGHT)
        elif event.is_action_pressed("down"):
            change_facing(FacingDirection.DOWN)
        elif event.is_action_pressed("left"):
            change_facing(FacingDirection.LEFT)
            
    if event.is_action_pressed("hit"):
        pass


func _physics_process(delta: float) -> void:
    direction = Input.get_vector("left","right","up","down")
    if direction:
        target_velocity = direction * SPEED
        # use of framerate indipendent lerp for acceleration and deceleration
        velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * delta))
    else:
        velocity = velocity.lerp(Vector2.ZERO, 1 - exp(-friction * delta))
    move_and_slide()


func change_facing(new_facing_direction: FacingDirection):
    # can make this more efficient using strings I think, but w/e
    if new_facing_direction != current_facing:
        current_facing = new_facing_direction
        match new_facing_direction:
            FacingDirection.UP:
                animated_sprite_2d.animation = "face_up"
                weapon_pivot.rotation_degrees = 180
            FacingDirection.RIGHT:
                animated_sprite_2d.animation = "face_right"
                weapon_pivot.rotation_degrees = 270
            FacingDirection.DOWN:
                animated_sprite_2d.animation = "face_down"
                weapon_pivot.rotation_degrees = 0
            FacingDirection.LEFT:
                animated_sprite_2d.animation = "face_left"
                weapon_pivot.rotation_degrees = 90
        
    
