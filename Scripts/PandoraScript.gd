extends Node2D

var chaos_level = 1
@export var prefabs: Array[PackedScene]

func _ready():
	$AnimationPlayer.play("open")

func spawn_weapon():
	var index = randi_range(3, prefabs.size() - 1)
	var weapon = prefabs[index].instantiate()
	if index == 2 or 3:
		get_node("/root/level/player").add_child(weapon)
	else:
		weapon.global_position = global_position
		get_tree().root.add_child(weapon)
