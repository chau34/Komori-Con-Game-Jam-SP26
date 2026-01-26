# res://scripts/House.gd
extends Node2D

@onready var dialogue_layer: CanvasLayer = $DialogueLayer

@onready var portrait: TextureRect = $DialogueLayer/DialogueRoot/DialoguePanel/Portrait
@onready var speaker_label: Label = $DialogueLayer/DialogueRoot/DialoguePanel/SpeakerLabel
@onready var dialogue_label: RichTextLabel = $DialogueLayer/DialogueRoot/DialoguePanel/DialogueLabel
@onready var hint_label: Label = $DialogueLayer/DialogueRoot/DialoguePanel/HintLabel

const CAT_PORTRAIT: Texture2D = preload("res://assets/cat-dialogue.png")
const OWNER_PORTRAIT: Texture2D = preload("res://assets/human-dialogue.png")

var lines := [
	{"speaker": "Cat", "text": "I must warn my owner!"},
	{"speaker": "Cat", "text": "*cat runs up to owner*"},
	{"speaker": "Cat", "text": "Meowwww, Meow Meow Meowww"},
	{"speaker": "Owner", "text": "Does she want something?"},
	{"speaker": "Owner", "text": "Does you need something?"},
	{"speaker": "Cat", "text": ".. .He can't understand me"},
	{"speaker": "Cat", "text": "I'll have to find another way to stop him"}
]

var idx: int = 0
var in_dialogue: bool = true

func _ready() -> void:
	if portrait == null or speaker_label == null or dialogue_label == null or hint_label == null:
		push_error("Dialogue UI nodes not found. Fix node paths in House.gd using Copy Node Path.")
		return

	_start_dialogue()

func _unhandled_input(event: InputEvent) -> void:
	if not in_dialogue:
		return

	if event.is_action_pressed("confirm") or event.is_action_pressed("ui_accept"):
		_next_line()

func _start_dialogue() -> void:
	in_dialogue = true
	idx = 0
	dialogue_layer.visible = true
	_show_line()

func _next_line() -> void:
	idx += 1
	if idx >= lines.size():
		_end_dialogue()
	else:
		_show_line()

func _show_line() -> void:
	var entry = lines[idx]
	var who := str(entry["speaker"])

	speaker_label.text = who
	dialogue_label.bbcode_text = "[left]" + str(entry["text"]) + "[/left]"
	hint_label.text = "Press Space to continue"

	match who:
		"Cat":
			portrait.texture = CAT_PORTRAIT
		"Owner":
			portrait.texture = OWNER_PORTRAIT
		_:
			portrait.texture = null

func _end_dialogue() -> void:
	in_dialogue = false
	dialogue_layer.visible = false
