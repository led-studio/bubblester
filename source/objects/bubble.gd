extends Area2D

@onready var player: CharacterBody2D;

var speed = 100
var player_pos
var target_pos
var last_position
var health = 1
var is_live = true
var can_track = true
var score = 5

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if is_live:
		player_pos = player.position
		
		if position.distance_to(player_pos) > 90 && can_track:
			target_pos = (player_pos - position).normalized()
			position += target_pos * speed * delta * Global.speed
		else:
			can_track = false
			if target_pos != null:
				position += target_pos * speed * delta * Global.speed
		
	if health <= 0 && is_live:
		is_live = false
		$CollisionShape2D.disabled = true
		$AnimatedSprite2D.play("die")
		await $AnimationPlayer.animation_finished
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	health -= 1
	if body.has_method("damage"):
		body.damage()
