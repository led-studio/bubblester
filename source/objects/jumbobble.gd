extends Area2D

@onready var player: CharacterBody2D;
@onready var tadbobble = preload("res://source/objects/tadbobble.tscn")

var speed = 45
var player_pos
var target_pos
var last_position
var health = 3
var score = 15
var is_live = true
var can_track = true

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if is_live:
		player_pos = player.position
		
		if position.distance_to(player_pos) > 10 && can_track:
			target_pos = (player_pos - position).normalized()
			position += target_pos * speed * delta * Global.speed
		else:
			can_track = false
			if target_pos != null:
				position += target_pos * speed * delta * Global.speed
		
	if health <= 0 && is_live:
		is_live = false
		$CollisionShape2D.disabled = true
		$AnimationPlayer.play("explode")
		await $AnimationPlayer.animation_finished
		for i in 3:
			var enemy = tadbobble.instantiate()
			enemy.position = position
			enemy.player = player
			get_parent().add_child(enemy)
		$AnimationPlayer.play("die")
		await $AnimationPlayer.animation_finished
		queue_free()
		

func _on_body_entered(body: Node2D) -> void:
	health -= 1
	if body.has_method("damage"):
		body.damage()
