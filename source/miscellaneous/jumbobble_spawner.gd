extends Node2D

@onready var bubble = preload("res://source/objects/jumbobble.tscn")
@onready var player: CharacterBody2D = $"../../Player"

var is_on_cooldown = false
var random

func _process(delta: float) -> void:
	pass

func spawn():
	var enemy = bubble.instantiate()
	enemy.position = position
	enemy.player = player
	enemy.position.x += randf_range(-300, 300)
	get_parent().add_child(enemy)

func _on_cycle_timeout() -> void:
	random = randi() % 10
	if random == 1.0:
		spawn()
	pass
	
	is_on_cooldown = false
	
func activate():
	$Cycle.start()
