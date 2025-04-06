extends Node

signal was_hit
@export var team = 0
@export var damage = 1
@export var die_on_hit: Node2D
@export var clear_enemy_projectiles = false
#@export var hitlimit = 1
#todo: if using hitlimit, need to track number of valid hits

func _on_was_hit() -> void:
	return
	#if die_on_hit != null:
		#die_on_hit.queue_free()

func _on_area_entered(area: Area2D) -> void:
	#If a player projectile hits an enemy projectile, delete it
	if area.get_collision_layer_value(4) and clear_enemy_projectiles:
		area.get_parent().queue_free()
	if die_on_hit != null:
		die_on_hit.queue_free()
