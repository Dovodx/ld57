extends CharacterBody2D

var speed = 200
var angle_min = 10
var angle_max = 40
var xmax = 512
var xmin = 0
var ymax = 288 - 16
var ymin = 0

func _ready() -> void:
	global_rotation_degrees = randf_range(angle_min, angle_max) * sign(randf_range(-1, 1))

func _physics_process(delta: float) -> void:
	if global_position.x > xmax or global_position.x < xmin:
		scale.x *= sign(global_position.x - (xmax - xmin) / 2)
	if global_position.y > ymax or global_position.y < ymin:
		scale.y *= sign(global_position.y - (ymax - ymin) / 2)
	velocity = -transform.y * speed
	move_and_slide()
