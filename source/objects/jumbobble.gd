extends Area2D

@onready var player: CharacterBody2D;
@onready var tadbobble = preload("res://source/objects/tadbobble.tscn")

var speed = 45
var player_pos
var target_pos
var last_position
var health = 3
var is_live = true
var can_track = true

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if is_live:
		player_pos = player.position
		
		if position.distance_to(player_pos) > 10 && can_track:
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
	for i in 3:
		var enemy = tadbobble.instantiate()
		enemy.position = position
		enemy.player = player
		get_parent().add_child(enemy)
	queue_free()
