extends Node2D

var spin_speed = 6
var sword_distance = 51
var num_swords = 8

func _ready() -> void:
	var angle_interval = 360 / num_swords
	for i in range(1, num_swords):
		var newsword = $hitbox.duplicate()
		newsword.rotation_degrees += angle_interval * i
		newsword.position = (Vector2.UP * sword_distance).rotated(deg_to_rad(angle_interval * i))
		newsword.name += str(i)
		add_child(newsword)

func _physics_process(delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
	global_rotation_degrees += spin_speed
