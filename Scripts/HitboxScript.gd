extends Node

signal was_hit
@export var team = 0
@export var damage = 1
@export var die_on_hit: Node2D
#@export var hitlimit = 1
#todo: if using hitlimit, need to track number of valid hits

func _on_was_hit() -> void:
	if die_on_hit != null:
		queue_free()
