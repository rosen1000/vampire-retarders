extends CharacterBody2D

signal death

@export var max_health = 100.0
var health = max_health
@export var speed = 600
# var damage_per_enemy = 20
var regen = 2

var wasMoving = false

func _ready():
	$HealthBar.max_value = max_health

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 0:
		wasMoving = true
		$HappyBoo.play_walk_animation()
	elif wasMoving:
		wasMoving = false
		$HappyBoo.play_idle_animation()

	#region Health handling
	if health < max_health:
		health = min(max_health, health + regen * delta)

	if health < max_health and !$HealthBar.visible:
		$HealthBar.visible = true
	elif health == max_health and $HealthBar.visible:
		$HealthBar.visible = false

	var touching_enemies = $HurtBox.get_overlapping_bodies() as Array[Enemy]
	if touching_enemies.size() > 0:
		for enemy in touching_enemies:
			health -= enemy.damage * delta
		if health <= 0:
			death.emit()
	$HealthBar.value = health
	#endregion
