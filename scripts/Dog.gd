extends CharacterBody2D

@export var active := false
@export var speed := 120.0

func _physics_process(delta):
	if not active:
		velocity = Vector2.ZERO
	else:
		# NPC behavior later goes here
		pass

	move_and_slide()
