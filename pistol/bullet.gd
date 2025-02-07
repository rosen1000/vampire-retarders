extends Area2D

@export var speed = 300
@export var max_range = 1200
@export var damage = 30
@export var damage_fluctuation = .2
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
		body.take_damage(damage + randf_range(-damage * damage_fluctuation, damage * damage_fluctuation))
	queue_free()
