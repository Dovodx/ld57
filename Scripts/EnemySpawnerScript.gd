extends Node

@export var enemies: Array[PackedScene]
@export var spawn_time = 1.0
@export var total_enemies_to_spawn = 10
@export var endless = false
var enemies_spawned = 0
var enemies_active = 0
var total_enemies_spawned = 0

func _ready() -> void:
	Global.level_complete = false
	$timer.wait_time = spawn_time

func _physics_process(delta: float) -> void:
	if endless: return
	if enemies_spawned == total_enemies_to_spawn and enemies_active == 0:
		Global.level_complete = true
		Global.levels_cleared = Global.current_level
		get_node("/root/level/hud").level_cleared()

func _on_timer_timeout() -> void:
	if !endless and enemies_spawned >= total_enemies_to_spawn:
		$timer.stop()
		return
	#todo: ramp up difficulty over time in endless mode
	if endless:
		#Spawn rate maxes out at 1000 enemies spawned
		$timer.wait_time = max(0.6 - (total_enemies_spawned * 0.0005), 0.1)
	
	var i = randi_range(0, enemies.size() - 1)
	var newenemy = enemies[i].instantiate()
	newenemy.global_position = Vector2(randf_range(26, 486), -36)
	newenemy.add_to_group("enemies") #maybe use different group for bosses if I get to those
	newenemy.connect("tree_exiting", _on_enemy_died)
	get_tree().root.get_node("level").add_child(newenemy)
	enemies_active += 1
	enemies_spawned += 1

func _on_enemy_died() -> void:
	enemies_active -= 1
