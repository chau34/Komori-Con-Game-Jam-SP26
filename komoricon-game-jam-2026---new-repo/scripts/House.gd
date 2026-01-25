extends Node2D

@onready var dialogue_layer: CanvasLayer = $DialogueLayer
@onready var speaker_label: Label = $DialogueLayer/DialoguePanel/VBoxContainer/SpeakerLabel
@onready var dialogue_label: Label = $DialogueLayer/DialoguePanel/VBoxContainer/DialogueLabel
@onready var hint_label: Label = $DialogueLayer/DialoguePanel/VBoxContainer/HintLabel

var dialogue := [
	{"speaker": "Cat", "text": "I must warn my owner!"},
	{"speaker": "Cat", "text": "*cat runs up to owner*"},
	{"speaker": "Cat", "text": "Meowwww, Meow Meow Meowww"},
	{"speaker": "Owner", "text": "Does she want something?\nDo you need something?"},
	{"speaker": "Cat", "text": "He can't understand me.\nI'll have to find another way to stop him..."}
]

var idx := 0
var in_dialogue := true

func _ready() -> void:
	_start_dialogue()

func _start_dialogue() -> void:
	in_dialogue = true
	idx = 0
	dialogue_layer.visible = true
	_show_line()

func _unhandled_input(event: InputEvent) -> void:
	if not in_dialogue:
		return

	if event.is_action_pressed("confirm") or event.is_action_pressed("ui_accept"):
		idx += 1
		if idx >= dialogue.size():
			_end_dialogue()
		else:
			_show_line()

func _show_line() -> void:
	var entry = dialogue[idx]
	speaker_label.text = str(entry["speaker"])
	dialogue_label.text = str(entry["text"])
	hint_label.text = "Press Space to continue"

func _end_dialogue() -> void:
	in_dialogue = false
	dialogue_layer.visible = false
	# After dialogue ends, gameplay continues (cat can move/interact)
	# If you want: GameState.last_message = "Find a way to stop him..."
