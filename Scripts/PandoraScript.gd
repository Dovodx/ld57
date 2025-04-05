extends Node2D

var chaos_level = 1
@export var prefabs: Array[PackedScene]

func _ready():
	$AnimationPlayer.play("open")

func spawn_weapon():
	var index = randi_range(1, prefabs.size() - 1)
	var weapon = prefabs[index].instantiate()
	#todo: maybe different spawn points for certain weapons?
	weapon.global_position = global_position
	get_tree().root.add_child(weapon)
