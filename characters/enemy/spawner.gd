extends Path2D

var enemy_scene = preload("res://characters/enemy/enemy.tscn")
var enemies_count = 0
var current_wave = 0

func start():
	next_wave()

func next_wave():
	current_wave += 1
	enemies_count = floori(current_wave ** 1.4 + 4)
	%WaveCounter.text = "Wave: %s\nEnemies: %s" % [current_wave, enemies_count]

	for i in range(enemies_count):
		get_tree().create_timer(randf_range(0, 2)).timeout.connect(func():
			spawn(false)
		)

func spawn(count_up = true):
	var enemy = enemy_scene.instantiate() as Enemy
	$PathFollow2D.progress_ratio = randf()
	enemy.global_position = $PathFollow2D.global_position
	enemy.target = get_parent()
	enemy.top_level = true
	enemy.death.connect(death)
	var hp = current_wave ** 2 + 30
	var diviation = current_wave * 10
	enemy.health = randi_range(hp - diviation, hp + diviation)
	if count_up:
		enemies_count += 1
	add_child(enemy)

func death():
	enemies_count -= 1
	%WaveCounter.text = "Wave: %s\nEnemies: %s" % [current_wave, enemies_count]
	if enemies_count == 0:
		next_wave()
