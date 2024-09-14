extends AudioStreamPlayer

var is_walking = false:
	set(v):
		if not v:
			stop()
		elif not playing:
			play()
		is_walking = v

func _on_finished() -> void:
	if is_walking:
		play()
