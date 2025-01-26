extends Node

var difficultyMultiplayer:int = 1
var speed:int = 1

func _process(_delta: float) -> void:
	speed = (Global.difficultyMultiplayer / 10)+1
	
func increase_difficulty():
	difficultyMultiplayer += 1
