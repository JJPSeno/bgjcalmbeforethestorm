extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity -= lerp(velocity, Vector2.ZERO, .7)
	move_and_slide()
