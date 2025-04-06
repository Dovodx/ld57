extends Node

func _ready():
	$"options_menu/exit button".connect("pressed", close_options)

func close_options():
	$options_bg.visible = false
	$options_menu.visible = false

func _on_start_pressed():
	get_tree().change_scene_to_packed(load("res://Scenes/campaign_screen.tscn"))

func _on_options_pressed():
	$options_bg.visible = true
	$options_menu.visible = true

func _on_quit_pressed():
	if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED and DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	get_tree().quit()
