extends Area2D

@onready var player: CharacterBody2D = $"../Player"

var speed = 100
var player_pos
var target_pos
var health = 1
var isLive = true

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		position += target_pos * speed * delta
		
	if health <= 0 && isLive:
		$AnimatedSprite2D.play("die")
		$CollisionShape2D.disabled = true
		$Timer.start()
		isLive = false

func _on_body_entered(body: Node2D) -> void:
	health -= 1
	if body.has_method("damage"):
		body.damage()

func _on_timer_timeout() -> void:
	queue_free()
