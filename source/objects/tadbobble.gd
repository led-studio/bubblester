extends Area2D

@onready var player: CharacterBody2D;

var speed = 175
var player_pos
var target_pos
var last_position
var spawn_pos:Vector2
var health = 1
var is_live = false
var is_dying = false
var can_track = true


func _ready() -> void:
	spawn_pos = position + Vector2(randf_range(-25, 25), randf_range(-50, 50))
	pass
	
func _physics_process(delta: float) -> void:
	# cuando spawnean y van a diferentes direcciones
	if !is_live:
		rotation += deg_to_rad(randi() % 180)
		position = lerp(position, spawn_pos, 5 * delta)
		
	if is_live:
		$AnimatedSprite2D.play("idle")
		player_pos = player.position
		
		if position.distance_to(player_pos) > 150 && can_track:
			target_pos = (player_pos - position).normalized()
			position += target_pos * speed * delta * ((Global.difficultyMultiplayer / 10) +1)
		else:
			can_track = false
			position += target_pos * speed * delta * ((Global.difficultyMultiplayer / 10) +1)
		
	if health <= 0 && is_live:
		$AnimatedSprite2D.play("die")
		$CollisionShape2D.disabled = true
		$Timer.start()
		is_live = false

func _on_body_entered(body: Node2D) -> void:
	health -= 1
	if body.has_method("damage"):
		body.damage()

func _on_timer_timeout() -> void:
	queue_free()

func _on_sleep_timeout() -> void:
	is_live = true
	can_track = true
	pass # Replace with function body.
