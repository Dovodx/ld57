extends CharacterBody2D

var speed = 1000

func _physics_process(delta: float):
	velocity = Vector2.UP * speed
	move_and_slide()

func _on_deathtimer_timeout():
	die()

func _on_hitbox_was_hit():
	die()

func die():
	queue_free()
