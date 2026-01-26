extends Control

@onready var cinematic_label: Label = $CinematicLabel
@onready var start_btn: Button = $"CenterContainer/PanelContainer/VBoxContainer/Start Button"
@onready var exit_btn: Button = $"CenterContainer/PanelContainer/VBoxContainer/Exit Button"

func _on_start_button_pressed() -> void:
	start_btn.disabled = true
	exit_btn.disabled = true
	start_btn.visible = false
	exit_btn.visible = false

	cinematic_label.visible = true
	await _run_cinematic()

	GameState.reset_run()
	if "last_message" in GameState:
		GameState.last_message = "Stop him before 9:00 PM."

	get_tree().change_scene_to_file("res://scenes/House.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _set_line(text: String) -> void:
	cinematic_label.text = text

func _pause(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

const EXTRA_DELAY := 2.0

func _run_cinematic() -> void:
	_set_line("vroom...\nvroom...")
	await _pause(1.2 + EXTRA_DELAY)

	_set_line("The time is 9:00 PM")
	await _pause(1.2 + EXTRA_DELAY)

	_set_line("A car is speeding down an unknown road,\nwith no goal to stop.")
	await _pause(1.6 + EXTRA_DELAY)

	_set_line("A familiar face leaves his home,\nand crosses the road to get to his car at 9:00 PM.")
	await _pause(2.2 + EXTRA_DELAY)

	_set_line("As he crosses the road,\nthe zooming car appears from nowhere and...")
	await _pause(1.8 + EXTRA_DELAY)

	_set_line("CRRASHHH")
	await _pause(1.2 + EXTRA_DELAY)
