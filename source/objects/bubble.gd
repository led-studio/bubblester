extends Area2D

@onready var player: CharacterBody2D = $"../Player"

var speed = 100
var player_pos
var target_pos
var health = 1


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * speed * delta
		
	if health <= 0:
		$AnimatedSprite2D.play("die")
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	health -= 1
