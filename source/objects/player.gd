extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 6000.0
const FRICTION = 3000.0

@onready var gun: AnimatedSprite2D = $Gun/AnimatedSprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var bullet_path = preload("res://source/objects/bullet.tscn")
var changing_side = false
var is_idle = true
var is_on_cooldown = false
var last_key_pressed = 0
var health = 3

func _physics_process(delta: float) -> void:
	# esto es para el movimiento del cañón
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
			is_idle = true
			velocity.x = 0

	move_and_slide()
	
	# Esto es para las animaciones
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
		
	if velocity.x != 0:
		if  !is_idle && direction != last_key_pressed && direction != 0:
			animation.play("quick")
			animation.queue("move")
			
		if !changing_side:
			animation.play("change_direction")
			animation.queue("move")
			
		changing_side = true
		is_idle = false
	else:
		is_idle = true
		changing_side = false
		animation.play("idle")
		
func _process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		last_key_pressed = 1
	elif Input.is_action_pressed("move_left"):
		last_key_pressed = -1
		
	if health == 0:
		animation.play("die")
		$Death.start()
	
func fire():
	is_on_cooldown = true
	gun.play("shoot")
	$Gun/LaunchTime.start()
	$Cooldown.start()

func damage():
	health -= 1
	if health != 0:
		pass #animation.play("hurt")

func _on_cooldown_timeout() -> void:
	is_on_cooldown = false

func _on_launch_time_timeout() -> void:
	var bullet = bullet_path.instantiate()
	bullet.dir = deg_to_rad(gun.rotation_degrees)
	bullet.pos = $Gun/AnimatedSprite2D/Point.global_position
	bullet.rota = deg_to_rad(gun.global_rotation_degrees)
	get_parent().add_child(bullet)


func _on_death_timeout() -> void:
	Global.restart()
	pass # Replace with function body.
