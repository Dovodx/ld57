extends CharacterBody2D

var shot_prefab = preload("res://Prefabs/enemy_3_shot.tscn")
var speed = 120
var current_speed = speed
var external_force = Vector2.ZERO
var external_force_decay = 0.99
var dir = Vector2.DOWN
var num_shots = 3
var current_shot_count = 0
var base_angle = Vector2.DOWN.angle()
var angle_max = 45
var angle_step = 15

var xmax = 512 - 24
var xmin = 24
var ymax = 288 / 2.5
var ymin = 20

func _ready() -> void:
	$movetimer.start()

func _physics_process(delta: float) -> void:
	if global_position.x > xmax:
		dir = Vector2(min(-abs(dir.x), -0.1), dir.y).normalized()
	elif global_position.x < xmin:
		dir = Vector2(max(abs(dir.x), 0.1), dir.y).normalized()
	if global_position.y > ymax:
		dir = Vector2(dir.x, min(-abs(dir.y), -0.1)).normalized()
	elif global_position.y < ymin:
		dir = Vector2(dir.x, max(abs(dir.y), -0.1)).normalized()
	velocity = dir * current_speed + external_force
	move_and_slide()
	external_force *= external_force_decay

func die():
	var sound = get_node_or_null("death sound")
	if sound != null:
		sound.reparent(get_parent())
		sound.connect("finished", sound.queue_free)
		sound.play_sfx()
	queue_free()

func _on_shottimer_timeout() -> void:
	if current_shot_count < num_shots:
		var shot = shot_prefab.instantiate()
		shot.global_position = global_position
		get_tree().root.get_node("level").add_child(shot)
		shot.dir = global_position.direction_to(get_node("/root/level/player").global_position)
		$"shoot sound".play_sfx()
		
		current_shot_count += 1
		$shottimer.start()
	else:
		$stoptimer.start()

func _on_movetimer_timeout() -> void:
	#done moving, stop and fire
	current_speed = 0
	$shottimer.start()

func _on_stoptimer_timeout() -> void:
	#done staying in place, start moving
	dir = Vector2.RIGHT.rotated(randf_range(0, 360))
	current_speed = speed
	$movetimer.start()

func _on_healthnode_died() -> void:
	die()

func _on_hitbox_area_entered(area: Area2D) -> void:
	die() #die when we ram into the player
