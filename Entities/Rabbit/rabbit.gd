extends CharacterBody2D

var harvestible:= false
@onready var audio:AudioStreamPlayer = %"Rabbit-squeek"
var random_direction:Vector2
const SPEED := 22
func _ready() -> void:
	QuestSystem.start_tailor_quest_2.connect(func ():harvestible = true)
	QuestSystem.finish_tailor_quest_2.connect(func ():harvestible = false)
	
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
	audio.play()
	if harvestible:
		QuestSystem.harvested_rabbits += 1
		hide()
		await audio.finished
		queue_free()


func _on_timer_timeout() -> void:
	pick_random_direction()
