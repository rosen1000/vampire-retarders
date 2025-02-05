extends CharacterBody2D

@export var speed = 300
@export var target: CharacterBody2D

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed
	move_and_slide()
	pass
