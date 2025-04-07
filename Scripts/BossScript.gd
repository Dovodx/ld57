extends CharacterBody2D

var shot_prefab = preload("res://Prefabs/enemy_2_shot.tscn")
var explosion_prefab = preload("res://Prefabs/boss explosion.tscn")

var speed = 90
var dir = Vector2.DOWN
var xmax = 512 - 64
var xmin = 64
var ymax = 288 - 200
var ymin = 48

var pattern = 0
var shots_left_in_pattern = 0
var firing_points: Array[Node2D]

var healthbar_max_size = 184.0
var healthbar: ColorRect

func _ready() -> void:
	for item in find_children("firepoint*", "Node2D"):
		firing_points.append(item)
	for item in firing_points:
		print("firepoint: " + str(item.name))
	$"next pattern timer".start()
	healthbar = get_node("/root/level/hud/boss healthbar/healthbar fill")
	healthbar.get_parent().visible = true

func _physics_process(delta: float) -> void:
	healthbar.size.x = $healthnode.health / $healthnode.maxhealth * healthbar_max_size
	if global_position.x > xmax:
		dir = Vector2(min(-abs(dir.x), -0.1), dir.y).normalized()
	elif global_position.x < xmin:
		dir = Vector2(max(abs(dir.x), 0.1), dir.y).normalized()
	if global_position.y > ymax:
		dir = Vector2(dir.x, min(-abs(dir.y), -0.1)).normalized()
	elif global_position.y < ymin:
		dir = Vector2(dir.x, max(abs(dir.y), -0.1)).normalized()
	velocity = dir * speed
	move_and_slide()

func fire():
	if shots_left_in_pattern == 0:
		$"next pattern timer".start()
		return
	match pattern:
		0:
			if shots_left_in_pattern > 0:
				var angle_deg = (shots_left_in_pattern - 1) * 30 + 45
				var shot_dir = Vector2.RIGHT.rotated(deg_to_rad(angle_deg))
				for item in firing_points:
					spawn_projectile(item.global_position, Vector2.DOWN)
				$"shoot sound".play_sfx()
				shots_left_in_pattern -= 1
				$"fire fast timer".start()
		1:
			if shots_left_in_pattern > 0:
				var angle_deg = (shots_left_in_pattern - 1) * 40 + 10
				var shot_dir = Vector2.RIGHT.rotated(deg_to_rad(angle_deg))
				for item in firing_points:
					spawn_projectile(item.global_position, shot_dir)
				$"shoot sound".play_sfx()
				shots_left_in_pattern -= 1
				$"fire medium timer".start()
		2:
			if shots_left_in_pattern > 0:
				var angle_deg = 90 + randf_range(-50, 50)
				var shot_dir = Vector2.RIGHT.rotated(deg_to_rad(angle_deg))
				for item in firing_points:
					spawn_projectile(item.global_position, shot_dir)
				$"shoot sound".play_sfx()
				shots_left_in_pattern -= 1
				$"fire slow timer".start()

func spawn_projectile(pos: Vector2, shot_dir: Vector2):
	var shot = shot_prefab.instantiate()
	shot.dir = shot_dir
	shot.global_position = pos
	get_tree().root.get_node("level").add_child(shot)

func _on_next_pattern_timer_timeout() -> void:
	pattern = randi_range(0, 2)
	match pattern:
		0:
			shots_left_in_pattern = 3
			$"fire fast timer".start()
		1:
			shots_left_in_pattern = 4
			$"fire medium timer".start()
		2:
			shots_left_in_pattern = 6
			$"fire slow timer".start()

func _on_fire_fast_timer_timeout() -> void:
	fire()

func _on_fire_medium_timer_timeout() -> void:
	fire()

func _on_fire_slow_timer_timeout() -> void:
	fire()

func _on_move_timer_timeout() -> void:
	dir = Vector2(dir.x, dir.y * 0.5).normalized()
	if randi_range(0, 3) == 1:
		dir.x = randf_range(0.5, 1)
		if randi_range(0, 1) == 1:
			dir.x *= -1
	if randi_range(0, 2) == 0:
		dir.x *= -1
	dir = dir.normalized()

func _on_healthnode_died() -> void:
	var explode = explosion_prefab.instantiate()
	explode.global_position = global_position
	get_tree().root.get_node("level").call_deferred("add_child", explode)
	healthbar.get_parent().visible = false
	queue_free()
