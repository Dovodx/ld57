extends Node2D

var explosion_prefab = preload("res://Prefabs/pandora/bomb explosion.tscn")

func explode():
	var explosion = explosion_prefab.instantiate()
	explosion.global_position = global_position
	get_tree().root.get_node("level").call_deferred("add_child", explosion)
	call_deferred("queue_free")
