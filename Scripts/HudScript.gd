extends Control

func _ready():
	if Global.current_level >= Global.levels.size():
		$victory/VBoxContainer/next.visible = false
		$victory/title.text = "Game Clear!\nTry endless mode!"
	$death.visible = false
	$"options_menu/exit button".connect("pressed", _on_options_exit_pressed)

func _process(delta: float) -> void:
	if Global.level_complete: return
	if Input.is_action_just_pressed("pause"):
		if $options_menu.visible:
			_on_options_exit_pressed()
		else:
			get_tree().paused = !get_tree().paused
			$"pause menu".visible = get_tree().paused

func level_cleared():
	get_tree().paused = false
	$death.visible = false
	$"pause menu".visible = false
	$options_menu.visible = false
	$victory.visible = true

func _on_resume_pressed() -> void:
	get_tree().paused = false
	$"pause menu".visible = false

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	if Global.current_level < 6:
		Global.start_level_music()

func _on_quit_pressed() -> void:
	#todo: go back to campaign screen if in campaign, main if endless mode
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("res://Scenes/main_menu.tscn"))

func _on_options_pressed() -> void:
	$options_menu.visible = true
	$"pause menu".visible = false

func _on_options_exit_pressed() -> void:
	$options_menu.visible = false
	$"pause menu".visible = true

func _on_next_pressed() -> void:
	get_tree().paused = false
	Global.current_level += 1
	Global.load_level(Global.current_level)
