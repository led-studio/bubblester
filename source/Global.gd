extends Node

var difficultyMultiplayer:int = 1

func restart()->void:
	get_tree().reload_current_scene()
	
func increase_difficulty():
	difficultyMultiplayer += 1
