extends CharacterBody2D

var speed = 200
var travel_angle = 0
var angle_min = 10
var angle_max = 40
var xmax = 512 - 24
var xmin = 24
var ymax = 288 - 16
var ymin = 16

func _ready() -> void:
	travel_angle = randf_range(angle_min, angle_max) * sign(randf_range(-1, 1))

func _physics_process(delta: float) -> void:
	var angle = Vector2.RIGHT.rotated(travel_angle)
	if global_position.x > xmax:
		angle = Vector2(-abs(angle.x), angle.y)
	elif global_position.x < xmin:
		angle = Vector2(abs(angle.x), angle.y)
	if global_position.y > ymax:
		angle = Vector2(angle.x, -abs(angle.y))
	elif global_position.y < ymin:
		angle = Vector2(angle.x, abs(angle.y))
	travel_angle = angle.angle()
	velocity = angle * speed
	move_and_slide()
