extends Node2D

func _ready() -> void:
	$GPUParticles2D.restart()

func _on_deathtimer_timeout() -> void:
	queue_free()

func _on_hitboxtimer_timeout() -> void:
	$hitbox.monitoring = false
	$hitbox.monitorable = false
