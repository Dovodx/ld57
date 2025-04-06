extends CharacterBody2D

var hit_active_time = 0.3
var hit_reset_time = 0.2
var speed = 150
var target: Vector2

func _ready() -> void:
	find_target()

func _physics_process(delta: float) -> void:
	velocity = (velocity + (target - global_position).normalized() * speed) / 2.0
	move_and_slide()

func find_target():
	target = global_position
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.is_empty():
		target = Vector2(randf_range(32, 512 - 32), randf_range(32, 288 - 64))
	else:
		target = enemies[0].global_position

func _on_hit_timer_timeout() -> void:
	if $hitbox/CollisionShape2D.disabled:
		$hitbox/CollisionShape2D.disabled = false
		$"hit timer".wait_time = hit_active_time
		$"hit timer".start()
	else:
		$hitbox/CollisionShape2D.disabled = true
		$"hit timer".wait_time = hit_reset_time
		$"hit timer".start()

func _on_target_timer_timeout() -> void:
	find_target()

func _on_death_timer_timeout() -> void:
	queue_free()
