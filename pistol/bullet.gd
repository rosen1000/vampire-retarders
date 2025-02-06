extends Area2D

@export var speed = 300
@export var max_range = 1200
var traveled = 0

func _physics_process(delta: float) -> void:
	# Get direction from angle
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += direction * speed * delta
	traveled += speed * delta
	if traveled > max_range:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(10 + randf_range(-2, 2))
	queue_free()
