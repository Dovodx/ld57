extends Node

var enemy1 = preload("res://Prefabs/enemy_1.tscn")

func _ready() -> void:
	$timer.wait_time = 0.5

func _on_timer_timeout() -> void:
	var newenemy = enemy1.instantiate()
	newenemy.global_position = Vector2(randf_range(26, 486), -36)
	newenemy.add_to_group("enemies") #maybe use different group for bosses if I get to those
	get_tree().root.add_child(newenemy)
