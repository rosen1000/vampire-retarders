class_name Enemy extends CharacterBody2D

@export var health = 100.0
@export var speed = 100
@export var target: CharacterBody2D

func _ready():
	$Slime.play_walk()
	$HealthBar.max_value = health
	$HealthBar.value = health

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(target.global_position)
	velocity = direction * speed
	move_and_slide()

var smoke_scene = preload("res://smoke_explosion/smoke_explosion.tscn")

func take_damage(dmg: float):
	health -= dmg
	$HealthBar.visible = true
	$HealthBar.value = health
	$Slime.play_hurt()
	if health <= 0:
		var smoke = smoke_scene.instantiate() as Node2D
		# Smoke not getting deleted with the enemy
		smoke.global_position = global_position
		get_parent().add_child(smoke)
		queue_free()
