extends CharacterBody2D

@export var speed := 120
@export var cat_node_path: NodePath  # assign in Inspector

@onready var cat: CharacterBody2D = get_node(cat_node_path)

func _physics_process(delta):
	if cat:
		var direction = (cat.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector2.ZERO
