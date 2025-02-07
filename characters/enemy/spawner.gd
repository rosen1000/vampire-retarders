extends Path2D

var enemy_scene = preload("res://characters/enemy/enemy.tscn")
var enemies_count = 0
var current_wave = 0

func start():
	next_wave()

func next_wave():
	current_wave += 1
	var count = floori(sqrt(current_wave * 20) + 1)
	%WaveCounter.text = "Wave: %s\nEnemies: %s" % [current_wave, count]

	for i in range(count):
		await get_tree().create_timer(randf_range(0, 2)).timeout
		spawn()

func spawn():
	var enemy = enemy_scene.instantiate() as Enemy
	$PathFollow2D.progress_ratio = randf()
	enemy.global_position = $PathFollow2D.global_position
	enemy.target = get_parent()
	enemy.top_level = true
	enemy.death.connect(death)
	enemies_count += 1
	add_child(enemy)

func death():
	enemies_count -= 1
	%WaveCounter.text = "Wave: %s\nEnemies: %s" % [current_wave, enemies_count]
	if enemies_count == 0:
		next_wave()
