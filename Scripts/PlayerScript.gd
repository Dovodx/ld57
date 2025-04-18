extends CharacterBody2D

var laser_prefab: PackedScene = preload("res://Prefabs/player_laser.tscn")
@onready var laser_timer = $"laser timer"

var pandora_prefab = preload("res://Prefabs/pandora's_box.tscn")

@onready var healthnode = $healthnode
@onready var healthbar_fill = $"/root/level/hud/healthbar fill"
var healthbar_max_size = 184.0

@onready var pandorabar_fill = $"/root/level/hud/pandora fill"
var pandora_meter = 0.0
var pandora_max = 100.0
var pandora_laser_add = 1

@onready var deathscreen = $"/root/level/hud/death"

var laser_cooldown = 0.2
var speed = 400

func _physics_process(delta: float):
	healthbar_fill.size.x = healthnode.health / healthnode.maxhealth * healthbar_max_size
	pandorabar_fill.size.x = pandora_meter / pandora_max * healthbar_max_size
	if healthnode.dead: return
	
	var input_dir = Vector2(Input.get_axis("left", "right"), Input.get_axis("forward", "back"))
	velocity = input_dir.normalized() * speed
	
	if Input.is_action_pressed("fire") && laser_timer.is_stopped():
		var tospawn = laser_prefab.instantiate()
		tospawn.get_node("hitbox").was_hit.connect(laser_hit)
		tospawn.global_position = global_position + Vector2.UP * 20
		get_tree().root.get_node("level").add_child(tospawn)
		laser_timer.start(laser_cooldown)
		$"laser sound".play_sfx()
	
	if Input.is_action_just_pressed("secondary_fire") && pandora_meter >= 25:
		pandora_meter -= 25
		var boxtospawn = pandora_prefab.instantiate()
		boxtospawn.position = Vector2.UP * 20
		add_child(boxtospawn)
	
	move_and_slide()

func laser_hit():
	pandora_meter = min(pandora_meter + pandora_laser_add, pandora_max)

func _on_healthnode_died():
	if Global.level_complete: return
	deathscreen.visible = true
	deathscreen.set_process_input(true)
	visible = false
	get_tree().root.get_node("level/enemy spawner/timer").stop()
	get_tree().paused = false
	get_node("/root/level/hud/pause menu").visible = false
	Global.stop_level_music()

func level_cleared():
	$hurtbox.queue_free()
