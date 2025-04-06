extends CharacterBody2D

var shot_prefab = preload("res://Prefabs/enemy_2_shot.tscn")
var speed = 50
var external_force = Vector2.ZERO
var external_force_decay = 0.99
var dir = Vector2.DOWN
var firerate = 1.6
var fire_angle = Vector2.DOWN.angle()
var base_angle = Vector2.DOWN.angle()
var angle_max = 45
var angle_step = 15

var xmax = 512 - 24
var xmin = 24
var ymax = 288 / 2.5
var ymin = 20

func _ready() -> void:
	$shottimer.wait_time = firerate
	$shottimer.start()

func _physics_process(delta: float) -> void:
	if global_position.x > xmax:
		dir = Vector2(min(-abs(dir.x), -0.1), dir.y).normalized()
	elif global_position.x < xmin:
		dir = Vector2(max(abs(dir.x), 0.1), dir.y).normalized()
	if global_position.y > ymax:
		dir = Vector2(dir.x, min(-abs(dir.y), -0.1)).normalized()
	elif global_position.y < ymin:
		dir = Vector2(dir.x, max(abs(dir.y), -0.1)).normalized()
	velocity = dir * speed + external_force
	move_and_slide()
	external_force *= external_force_decay

func die():
	queue_free()

func _on_shottimer_timeout() -> void:
	var shot = shot_prefab.instantiate()
	shot.dir = Vector2.RIGHT.rotated(fire_angle)
	shot.global_position = global_position
	get_tree().root.get_node("level").add_child(shot)
	if (fire_angle >= base_angle + deg_to_rad(angle_max) or
		fire_angle <= base_angle - deg_to_rad(angle_max)):
		angle_step *= -1
	fire_angle = fire_angle + deg_to_rad(angle_step)

func _on_directiontimer_timeout() -> void:
	dir = Vector2.RIGHT.rotated(randf_range(0, 360))

func _on_healthnode_died() -> void:
	die()

func _on_hitbox_area_entered(area: Area2D) -> void:
	die() #die when we ram into the player
