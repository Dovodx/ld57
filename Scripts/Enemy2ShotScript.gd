extends CharacterBody2D

@export var speed = 100
var dir = Vector2.DOWN
var external_force = Vector2.ZERO
var external_force_decay = 0.99

func _physics_process(delta: float) -> void:
	velocity = dir * speed + external_force
	move_and_slide()
	external_force *= external_force_decay

func _on_hitbox_was_hit() -> void:
	queue_free()
