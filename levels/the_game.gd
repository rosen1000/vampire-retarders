extends Node2D

var enemy_scene = preload("res://characters/enemy/enemy.tscn")
@onready var spawner = $Player/Spawner

func _ready():
	for i in range(10):
		spawner.spawn()
