extends CharacterBody2D

var suckforce = 100

func _ready() -> void:
	$AnimationPlayer.play("suck")

func _physics_process(delta: float) -> void:
	if $suck.monitoring == false: return
	for item in get_tree().get_nodes_in_group("enemies"):
		if (item.global_position.y < global_position.y - 20 and
			item.global_position.y > global_position.y - 170 and
			abs(item.global_position.x - global_position.x) < 100):
			item.external_force += (global_position - item.global_position).normalized() * suckforce
