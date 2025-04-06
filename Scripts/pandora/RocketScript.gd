extends CharacterBody2D

var speed = 300
var explosion_prefab = preload("res://Prefabs/pandora/rocket_explosion.tscn")

func _physics_process(delta: float) -> void:
	velocity = lerp(velocity, Vector2.UP * speed, 1 * delta)
	move_and_slide()
	if global_position.y <= 16:
		explode()

func _on_hitbox_area_entered(area: Area2D) -> void:
	var node_hit = area.get_parent().get_node_or_null("healthnode")
	if node_hit == null or node_hit.get("team") == null: return
	if node_hit.team != 0:
		explode()

func explode():
	var explosion = explosion_prefab.instantiate()
	explosion.global_position = global_position
	get_tree().root.get_node("level").call_deferred("add_child", explosion)
	call_deferred("queue_free")
