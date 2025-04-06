extends Node

var current_level = 1
var level_complete = false
var levels_cleared = 0

var levels: Array[PackedScene] = [
	preload("res://Scenes/level1.tscn"),
	preload("res://Scenes/level2.tscn"),
	preload("res://Scenes/level3.tscn"),
	preload("res://Scenes/level4.tscn"),
	preload("res://Scenes/level5.tscn"),
]

func toggle_fullscreen():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

func load_level(level_num = current_level):
	get_tree().call_deferred("unload_current_scene")
	get_tree().change_scene_to_packed(levels[current_level - 1])
	if level_num < 6:
		start_level_music()

func start_level_music():
	if !$"level music".playing:
		$"level music".play()

func stop_level_music():
	$"level music".stop()
