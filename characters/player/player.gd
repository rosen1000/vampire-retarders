extends CharacterBody2D

@export var speed = 800

var wasMoving = false

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 0:
		wasMoving = true
		$HappyBoo.play_walk_animation()
	elif wasMoving:
		wasMoving = false
		$HappyBoo.play_idle_animation()
pass
