extends CharacterBody2D


var SPEED := 200.0
var acceleration := 12.0
var friction := 15.0
var direction := Vector2.ZERO
var target_velocity := Vector2.ZERO
var current_facing : int
var can_swing := true
var weapon: Area2D

@onready var weapon_controller: Node2D = $WeaponPivot/WeaponController
@onready var weapon_pivot: Node2D = $WeaponPivot
@onready var animated_sprite_2d: AnimatedSprite2D = $"Bobble Target/AnimatedSprite2D"
@onready var bobbeable = $Bobbeable

enum FacingDirection {UP, RIGHT, DOWN, LEFT}


func _ready() -> void:
	weapon_controller.connect("weapon_changed", _on_weapon_changed)
	weapon = weapon_controller.return_current_weapon()
	weapon.monitorable = false
	weapon.monitoring = false
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
			
	if event.is_action_pressed("hit") and can_swing:
		swing_weapon()


func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left","right","up","down")
	if direction:
		target_velocity = direction * SPEED
		# use of framerate indipendent lerp for acceleration and deceleration
		velocity = velocity.lerp(target_velocity, 1 - exp(-acceleration * delta))
	else:
		velocity = velocity.lerp(Vector2.ZERO, 1 - exp(-friction * delta))
	bobbeable.is_bobbing = snapped(velocity.length(),4) > 0
	move_and_slide()


func change_facing(new_facing_direction: FacingDirection) -> void:
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
		
	
func swing_weapon() -> void:
	can_swing = false
	set_weapon_monitor(true)
	create_weapon_active_timer()
	for child in weapon_controller.get_children():
		if child.is_visible_in_tree() and child.has_method('_on_interact'):
			child._on_interact()

func create_weapon_active_timer() -> void:
	var timer := Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.one_shot = true
	timer.start()
	timer.connect("timeout", _on_timer_timeout.bind(timer))


func set_weapon_monitor(value: bool):
	weapon.monitorable = value
	weapon.monitoring = value


func _on_timer_timeout(timer: Timer) -> void:
	can_swing = true
	set_weapon_monitor(false)
	timer.queue_free()


func _on_weapon_changed(new_weapon: Area2D) -> void:
	weapon = new_weapon
