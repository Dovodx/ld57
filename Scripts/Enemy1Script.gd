extends CharacterBody2D

var speed = 100
var external_force = Vector2.ZERO
var external_force_decay = 0.99

func _physics_process(delta: float) -> void:
	velocity = Vector2.DOWN * speed + external_force
	if global_position.y >= 322:
		die()
	move_and_slide()
	external_force *= external_force_decay

func die():
	queue_free()
	#todo: different cases for dying to player vs going offscreen

func _on_healthnode_died() -> void:
	die()

func _on_hitbox_area_entered(area: Area2D) -> void:
	die() #die when we ram into the player
