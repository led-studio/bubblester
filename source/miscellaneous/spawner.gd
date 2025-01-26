extends Node2D

@onready var bubble = preload("res://source/objects/jumbobble.tscn")
@onready var player: CharacterBody2D = $"../../Player"

var is_on_cooldown = false


func _ready() -> void:
	print("Spawner loaded")

func spawn():
	var enemy = bubble.instantiate()
	enemy.position = position
	enemy.player = player
	enemy.position.x += randf_range(-300, 300)
	get_parent().add_child(enemy)

func _on_cooldown_timeout() -> void:
	is_on_cooldown = false
