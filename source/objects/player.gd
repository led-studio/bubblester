extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 6000.0
const FRICTION = 3000.0

@onready var gun: AnimatedSprite2D = $Gun/AnimatedSprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var bullet_path = preload("res://source/objects/bullet.tscn")
var changing_side = false
var is_on_cooldown = false

func _physics_process(delta: float) -> void:
	# esto es para el cañón
	gun.look_at(get_global_mouse_position())
	
	if gun.rotation_degrees > 135:
		gun.rotation_degrees = 135
	elif gun.rotation_degrees < 45:
		gun.rotation_degrees = 45
	
	if Input.is_action_pressed("action") && !is_on_cooldown:
		fire()
		
	# Este es el movimiento básico
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity += Vector2(direction * ACCELERATION * delta, 0)
		velocity = velocity.limit_length(SPEED)
	else:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity.x = 0

	move_and_slide()
	
	# Esto es para las animaciones
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	if direction != 0:
		if !changing_side:
			animation.play("change_direction")
			animation.queue("move")
			changing_side = true
	else:
		changing_side = false
		animation.play("idle")
	
func fire():
	is_on_cooldown = true
	gun.play("shoot")
	$Gun/LaunchTime.start()
	$Cooldown.start()


func _on_cooldown_timeout() -> void:
	is_on_cooldown = false


func _on_launch_time_timeout() -> void:
	var bullet = bullet_path.instantiate()
	bullet.dir = deg_to_rad(gun.rotation_degrees)
	bullet.pos = $Gun/AnimatedSprite2D/Point.global_position
	bullet.rota = deg_to_rad(gun.global_rotation_degrees)
	get_parent().add_child(bullet)
