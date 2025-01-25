extends CharacterBody2D

@onready var gun_sprite: AnimatedSprite2D = $Gun/AnimatedSprite2D
var bullet_path = preload("res://source/objects/bullet.tscn")
const SPEED = 300.0

func _physics_process(delta: float) -> void:
	# esto es para el cañón
	gun_sprite.look_at(get_global_mouse_position())
	
	if gun_sprite.rotation_degrees > 135:
		gun_sprite.rotation_degrees = 135
	elif gun_sprite.rotation_degrees < 45:
		gun_sprite.rotation_degrees = 45
	
	if Input.is_action_just_pressed("action"):
		fire()
		
	# Este es el movimiento básico
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Esto es para las animaciones
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	if direction != 0:
		$AnimationPlayer.play("change_direction")
		$AnimationPlayer.queue("move")
	else:
		$AnimationPlayer.play("idle")
	
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = deg_to_rad(gun_sprite.rotation_degrees)
	bullet.pos = $Gun/AnimatedSprite2D/Point.global_position
	bullet.rota = deg_to_rad(gun_sprite.global_rotation_degrees)
	gun_sprite.play("shoot")
	get_parent().add_child(bullet)
