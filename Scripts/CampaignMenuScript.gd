extends Control

func _ready() -> void:
	var levels_unlocked = Global.levels_cleared + 1
	var i = 1
	for item in $"button container".get_children():
		item.visible = i <= levels_unlocked
		i += 1

func _on_level_button_pressed(level_num = 1) -> void:
	Global.load_level(level_num)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Scenes/main_menu.tscn"))
