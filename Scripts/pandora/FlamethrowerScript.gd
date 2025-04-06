extends Node2D

@export var hitbox_active = true
var damage = 0.5
var counter = 0
@export var hitbox: RectangleShape2D

func _ready() -> void:
	$AnimationPlayer.play("flame")

func _physics_process(delta: float) -> void:
	if hitbox_active:
		$hitbox/box.disabled = counter % 4 == 0
		counter += 1
	else:
		$hitbox/box.disabled = true
	#if hitbox_active == false: return
	#for item in get_tree().get_nodes_in_group("enemies"):
		#if (item.global_position.y > $box.global_position.y - $box.shape.size.y / 1.8 and
			#item.global_position.y < $box.global_position.y + $box.shape.size.y / 1.8 and
			#item.global_position.x > $box.global_position.x - $box.shape.size.x / 1.8 and
			#item.global_position.x < $box.global_position.x + $box.shape.size.x / 1.8):
			#item.get_node("healthnode").take_damage(damage)
