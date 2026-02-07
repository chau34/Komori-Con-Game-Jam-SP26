extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var target: Node2D # Drag the player node here in the inspector
var follow_speed = 10.0

func _physics_process(delta):
	if target:
		# Smoothly move towards the target's position
		global_position = global_position.lerp(target.global_position, follow_speed * delta)
