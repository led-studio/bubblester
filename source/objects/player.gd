extends CharacterBody2D

const SPEED = 300.0
const ACCELERATION = 6000.0
const FRICTION = 3000.0

@onready var gun: AnimatedSprite2D = $Gun/Launcher
@onready var animation: AnimationPlayer = $AnimationPlayer

var torpedo_path = preload("res://source/objects/torpedo.tscn")
var bullet_path = preload("res://source/objects/bullet.tscn")
var pellet_path = preload("res://source/objects/pellet.tscn")


var last_key_pressed = 0
var current_gun = 0

var changing_side = false
var is_idle = true
var is_on_cooldown = false
var health = 3
var can_move = true
var is_dying = false
var is_hurt = false

func _physics_process(delta: float) -> void:
	if !can_move:
		return
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
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
		
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
		
func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		last_key_pressed = 1
	elif Input.is_action_pressed("move_left"):
		last_key_pressed = -1
		
	if health <= 0 && !is_dying:
		can_move = false
		is_dying = true
		animation.play("die")
		await $AnimationPlayer.animation_finished
		Transition.restart()
	
func fire():
	gun.play("shoot")
	is_on_cooldown = true
	$Cooldown.start()
	$Gun/LaunchTime.start()

func damage():
	if !is_hurt:
		health -= 1
		$Effects.play("hurt")
	
func set_hurt():
	is_hurt = !is_hurt
	
func change_gun(number:int):
	current_gun = number
	$Gun/Launcher.visible = false
	$Gun/Musket.visible = false
	$Gun/Machinegun.visible = false
	$Gun/LaunchTime.wait_time = 0.2
	match number:
		0:
			gun = $Gun/Launcher
			$Gun/Launcher.visible = true
			$Cooldown.wait_time = 0.5
		1:
			gun = $Gun/Musket
			$Gun/Musket.visible = true
		2:
			gun = $Gun/Machinegun
			$Gun/Machinegun.visible = true
			$Cooldown.wait_time = 0.075
			$Gun/LaunchTime.wait_time = 0.015
	pass

func _on_cooldown_timeout() -> void:
	gun.play("idle")
	is_on_cooldown = false

func _on_launch_time_timeout() -> void:
	spawn_bullet()
	
func spawn_bullet() -> void:
	var bullet
	match current_gun:
		0:
			bullet = torpedo_path.instantiate()
			bullet.pos = $Gun/Launcher/Point.global_position
			bullet.dir = deg_to_rad(gun.rotation_degrees)
			bullet.rota = deg_to_rad(gun.global_rotation_degrees)
			get_parent().add_child(bullet)
		1:
			bullet = pellet_path.instantiate()
			bullet.pos = $Gun/Musket/Point.global_position
			bullet.dir = deg_to_rad(gun.rotation_degrees + 25)
			bullet.rota = deg_to_rad(gun.global_rotation_degrees + 25)
			get_parent().add_child(bullet)
			
			var bullet2 = pellet_path.instantiate()
			bullet2.pos = $Gun/Musket/Point.global_position
			bullet2.dir = deg_to_rad(gun.rotation_degrees)
			bullet2.rota = deg_to_rad(gun.global_rotation_degrees)
			get_parent().add_child(bullet2)
			
			var bullet3 = pellet_path.instantiate()
			bullet3.pos = $Gun/Musket/Point.global_position
			bullet3.dir = deg_to_rad(gun.rotation_degrees - 25)
			bullet3.rota = deg_to_rad(gun.global_rotation_degrees - 25)
			get_parent().add_child(bullet3)
		2:
			bullet = bullet_path.instantiate()
			bullet.pos = $Gun/Machinegun/Point.global_position
			bullet.dir = deg_to_rad(gun.rotation_degrees)
			bullet.rota = deg_to_rad(gun.global_rotation_degrees)
			get_parent().add_child(bullet)
