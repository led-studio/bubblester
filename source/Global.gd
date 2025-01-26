extends Node

var difficultyMultiplayer:int = 1
var speed:float = 1
	
func increase_difficulty():
	difficultyMultiplayer += 1
	speed += 0.1
