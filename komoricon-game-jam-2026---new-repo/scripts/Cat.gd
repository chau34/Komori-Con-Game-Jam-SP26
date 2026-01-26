extends CharacterBody2D


const SPEED = 100.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction_x < 0:
		$AnimatedCat.flip_h = true
	elif direction_x > 0:
		$AnimatedCat.flip_h = false

	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_parkour_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://scenes/Parkour.tscn")


func _on_fight_body_entered(body: Node2D) -> void:
	if body == self:
		get_tree().change_scene_to_file("res://scenes/End.tscn")
