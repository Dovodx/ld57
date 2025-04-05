extends CharacterBody2D

@export var laser_prefab: PackedScene = preload("res://Prefabs/player_laser.tscn")
@onready var laser_timer = $"laser timer"
var laser_cooldown = 0.25
var speed = 400

func _physics_process(delta: float):
	var input_dir = Vector2(Input.get_axis("left", "right"), Input.get_axis("forward", "back"))
	velocity = input_dir.normalized() * speed
	
	if Input.is_action_pressed("fire") && laser_timer.is_stopped():
		var tospawn = laser_prefab.instantiate()
		tospawn.global_position = global_position + Vector2.UP * 20
		get_tree().root.add_child(tospawn)
		laser_timer.start(laser_cooldown)
	
	move_and_slide()
