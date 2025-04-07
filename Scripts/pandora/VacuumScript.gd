extends CharacterBody2D

var suckforce = 100
@export var suck_active = false
var counter = 0

func _ready() -> void:
	$AnimationPlayer.play("suck")

func _physics_process(delta: float) -> void:
	if suck_active:
		$suck/CollisionPolygon2D.disabled = counter % 3 == 0
		counter += 1
	else:
		$suck/CollisionPolygon2D.disabled = true

func _on_suck_area_entered(area: Area2D) -> void:
	if area.get_parent().get("external_force") != null:
		area.get_parent().external_force += (global_position - area.get_parent().global_position).normalized() * suckforce

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(4):
		area.get_parent().queue_free()
		$"scoop sound".play()
