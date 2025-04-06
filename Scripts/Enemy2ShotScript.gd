extends CharacterBody2D

var speed = 100
var dir = Vector2.DOWN

func _physics_process(delta: float) -> void:
	velocity = dir * speed
	move_and_slide()

func _on_hitbox_was_hit() -> void:
	queue_free()
