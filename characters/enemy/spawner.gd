extends Path2D

var enemy_scene = preload("res://characters/enemy/enemy.tscn")

func spawn():
	var enemy = enemy_scene.instantiate() as Enemy
	$PathFollow2D.progress_ratio = randf()
	enemy.global_position = $PathFollow2D.global_position
	enemy.target = get_parent()
	enemy.top_level = true
	add_child(enemy)
