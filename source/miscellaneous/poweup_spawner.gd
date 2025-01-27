extends Node2D

@onready var powerup = preload("res://source/miscellaneous/powerup.tscn")
@onready var player: CharacterBody2D = $"../../Player"

var is_on_cooldown = false
var random

func _process(delta: float) -> void:
	pass

func spawn():
	print("sapwned item")
	var item = powerup.instantiate()
	item.position = position
	item.position.x += randf_range(-300, 300)
	get_parent().add_child(item)

func _on_cycle_timeout() -> void:
	random = randi() % 10
	if random == 1.0:
		spawn()
	pass
	
	is_on_cooldown = false

func activate():
	$Cycle.start()
