extends AudioStreamPlayer2D

@export var pitch_variance = 0.0

func play_sfx() -> void:
	if pitch_variance != 0.0:
		change_pitch()
	super.play()

func change_pitch():
	pitch_scale = randf_range(1.0 - pitch_variance, 1.0 + pitch_variance)
