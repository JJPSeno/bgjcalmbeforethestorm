extends CharacterBody2D


var speed = 100.0
var accel = 3
var target : Node2D
var all_targets
@onready var nav: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	all_targets = GameManager.zom_targets
	target = all_targets[0]
	
func _physics_process(delta: float) -> void:
	if is_dead: return
	var direction = Vector3.ZERO
	for candidate in all_targets:
		if candidate == target:
			continue
		if global_position.distance_squared_to(candidate.global_position) <= global_position.distance_squared_to(target.global_position):
			target = candidate
			
	if !target == null:
		nav.target_position = target.global_position
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, 1 - exp(-accel * delta))
	
	move_and_slide()

var  is_dead := false
func interact():
	if is_dead: return
	
	is_dead = true
	hide()
	
	$ZombieWeapon/CollisionShape2D.disabled = true
	var sound = [%Zombie1, %Zombie2, %Zombie3][randi_range(0,2)]
	sound.play()
	await sound.finished
	queue_free()
	
