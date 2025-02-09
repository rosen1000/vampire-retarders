extends Node2D

var enemy_scene = preload("res://characters/enemy/enemy.tscn")
@onready var spawner = %Spawner
var current_wave = 0

func _ready():
	Inventory.connect("coin_changed", func():
		%CoinCount.text = str(Inventory.coins)
	)
	spawner.start()

func _on_player_death() -> void:
	%GameOver.visible = true
	get_tree().paused = true
