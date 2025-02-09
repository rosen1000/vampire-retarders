class_name Coin
extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("float")

func collect():
	Inventory.add_coins(1)
	queue_free()
