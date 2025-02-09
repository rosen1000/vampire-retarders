extends Area2D

@export var _range = 600
var bullet_scene = preload("res://pistol/bullet.tscn")
var line: Line2D

func _ready():
	line = Line2D.new()
	line.width = 2
	$Range.shape.radius = _range

func _physics_process(_delta: float) -> void:
	var found_enemies = get_overlapping_bodies()
	if found_enemies.size() > 0:
		var target = found_enemies[0]
		var distance = global_position.distance_squared_to(found_enemies[0].global_position)
		for enemy in found_enemies:
			var dist = global_position.distance_squared_to(enemy.global_position)
			if dist < distance:
				target = enemy
		# draw_line(global_position, target.global_position, Color.RED, 10)
		line.clear_points()
		line.add_point(global_position)
		line.add_point(target.global_position)
		look_at(target.global_position)

	#region Flip gun
	var direction = Vector2.RIGHT.rotated(global_rotation)
	if direction.x < 0:
		$Pivot/Pistol.scale.y = -1
	else:
		$Pivot/Pistol.scale.y = 1
	#endregion

func shoot():
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.global_position = %BulletMarker.global_position
	bullet.global_rotation = %BulletMarker.global_rotation
	%BulletMarker.add_child(bullet)

func _on_timer_timeout() -> void:
	var found_enemies = get_overlapping_bodies()
	if found_enemies.size() > 0:
		shoot()
