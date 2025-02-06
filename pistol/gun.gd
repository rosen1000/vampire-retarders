extends Area2D

var bullet_scene = preload("res://pistol/bullet.tscn")

func _physics_process(_delta: float) -> void:
	var found_enemies = get_overlapping_bodies()
	if found_enemies.size() > 0:
		var target = found_enemies[0]
		look_at(target.global_position)

func shoot():
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.global_position = %BulletMarker.global_position
	bullet.global_rotation = %BulletMarker.global_rotation
	%BulletMarker.add_child(bullet)

func _on_timer_timeout() -> void:
	var found_enemies = get_overlapping_bodies()
	if found_enemies.size() > 0:
		shoot()
