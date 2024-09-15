extends CharacterBody2D

@onready var audio:AudioStreamPlayer = %"SlimeSquish"
var random_direction:Vector2
var harvested = false
const SPEED := 15
func _ready() -> void:
	pick_random_direction.call_deferred()
	
func _physics_process(delta: float) -> void:
	move_and_collide(random_direction * delta)
	


func pick_random_direction():
	random_direction = Vector2(
		randi_range(-SPEED,SPEED),
		randi_range(-SPEED,SPEED)
	)
	
	await get_tree().create_timer(randi_range(1.5, 4)).timeout
	pick_random_direction.call_deferred()


func interact():
	if harvested: return
	harvested = true
	audio.play()
	hide()
	await audio.finished
	queue_free()

func _on_timer_timeout() -> void:
	pick_random_direction()
