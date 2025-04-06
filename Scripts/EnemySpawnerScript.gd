extends Node

@export var enemies: Array[PackedScene]

func _ready() -> void:
	$timer.wait_time = 0.5

func _on_timer_timeout() -> void:
	var i = randi_range(0, enemies.size() - 1)
	var newenemy = enemies[i].instantiate()
	newenemy.global_position = Vector2(randf_range(26, 486), -36)
	newenemy.add_to_group("enemies") #maybe use different group for bosses if I get to those
	get_tree().root.add_child(newenemy)
