extends Node

signal coin_changed

var coins = 0

func add_coins(ammount: int):
	coins += ammount
	coin_changed.emit()
