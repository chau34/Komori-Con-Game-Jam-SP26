extends Control
#signal start_game

#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("confirm"):
		#emit_signal("start_game")
		#


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/House.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
