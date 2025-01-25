extends Area2D

var speed = 50
var player_pos
var target_pos
@onready var player: CharacterBody2D = $"../Player"


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * speed * delta
