extends CanvasLayer

@onready var time_label: Label = $TimeLabel
@onready var concern_bar: ProgressBar = $ConcernBar
@onready var anger_bar: ProgressBar = $AngerBar
@onready var message_label: Label = $MessageLabel

func _ready() -> void:
	update_from_state()

func update_from_state() -> void:
	# Update time
	time_label.text = "Time: " + _format_time(GameState.current_hour)

	# Update meters
	concern_bar.value = GameState.concern
	anger_bar.value = GameState.anger

	# Update message
	if "last_message" in GameState:
		message_label.text = GameState.last_message

func _format_time(hour: int) -> String:
	var suffix := "AM"
	var display_hour := hour

	if hour == 0:
		display_hour = 12
	elif hour == 12:
		suffix = "PM"
	elif hour > 12:
		display_hour = hour - 12
		suffix = "PM"

	return str(display_hour) + ":00 " + suffix
