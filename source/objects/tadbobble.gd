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
var score = 2


func _ready() -> void:
	spawn_pos = position + Vector2(randf_range(-25, 25), randf_range(-50, 50))
	rotation += deg_to_rad(randi() % 180)
	pass
	
func _physics_process(delta: float) -> void:
	# cuando spawnean y van a diferentes direcciones
	if !is_live:
		position = lerp(position, spawn_pos, 5 * delta)
		
	if is_live:
		$AnimatedSprite2D.play("idle")
		player_pos = player.position
		
		# flip para apuntar al jugador
		if position < player_pos:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
		
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
		$AnimationPlayer.play("die")
		await $AnimationPlayer.animation_finished
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	health -= 1
	if body.has_method("damage"):
		body.damage()

func _on_sleep_timeout() -> void:
	is_live = true
	can_track = true
	rotation = 0
	pass # Replace with function body.
