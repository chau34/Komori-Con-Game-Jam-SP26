extends Node
const START_HOUR: int = 9
const END_HOUR: int = 21

const MAX: int = 100
const GOOD_ENDING_CONCERN: int = 70
const ANGER_LOCKED: int = 100

const WIN_CONCERN: int = 15
const LOSE_ANGER: int = 20

const TRASH_WIN_CONCERN: int = 25
const TRASH_LOSE_ANGER: int = 35

var current_hour: int = START_HOUR
var concern: int = 0
var anger: int = 0

func reset_run() -> void:
	current_hour = START_HOUR
	concern = 0
	anger = 0

func apply_win(kind: String = "") -> void:
	# kind can be: "trash" or anything else
	if kind == "trash":
		concern += TRASH_WIN_CONCERN
	else:
		concern += WIN_CONCERN
	_clamp_meters()

func apply_loss(kind: String = "") -> void:
	if kind == "trash":
		anger += TRASH_LOSE_ANGER
	else:
		anger += LOSE_ANGER
	_clamp_meters()

func advance_time(hours: int = 1) -> void:
	current_hour += hours
	if current_hour > END_HOUR:
		current_hour = END_HOUR

func is_game_over() -> bool:
	# Anger max -> locked in room
	return anger >= ANGER_LOCKED

func is_day_over() -> bool:
	return current_hour >= END_HOUR

func get_ending() -> String:
	if concern >= GOOD_ENDING_CONCERN and not is_game_over():
		return "good"
	return "bad"

# ---- Helpers ----
func _clamp_meters() -> void:
	concern = clamp(concern, 0, MAX)
	anger = clamp(anger, 0, MAX)
