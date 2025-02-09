extends CharacterBody2D

signal death

@export var max_health = 100.0
@export var speed = 600
var health = max_health
var regen = 2

var attracted: Array[Coin] = []
var wasMoving = false

func _ready():
	$HealthBar.max_value = max_health

func _physics_process(delta: float) -> void:
	#region Movement
	var direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	velocity = direction * speed
	move_and_slide()

	if velocity.length() > 0:
		wasMoving = true
		$HappyBoo.play_walk_animation()
	elif wasMoving:
		wasMoving = false
		$HappyBoo.play_idle_animation()
	#endregion

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

	for coin in attracted:
		if coin == null:
			continue
		var dir = coin.global_position.direction_to(global_position)
		coin.position += dir * 400 * delta
		if coin.global_position.distance_squared_to(global_position) < 1000:
			coin.collect()
			attracted.erase(coin)

func _on_pickup_range_area_entered(area: Area2D) -> void:
	if is_instance_of(area, Coin):
		attracted.push_front(area)
