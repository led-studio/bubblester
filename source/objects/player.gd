extends CharacterBody2D

@onready var gun_sprite: Sprite2D = $Gun/Sprite2D
var bullet_path = preload("res://source/objects/bullet.tscn")
const SPEED = 300.0

func _physics_process(delta: float) -> void:
	gun_sprite.look_at(get_global_mouse_position())
	
	if gun_sprite.rotation_degrees > 135:
		gun_sprite.rotation_degrees = 135
	elif gun_sprite.rotation_degrees < 45:
		gun_sprite.rotation_degrees = 45
	
	if Input.is_action_just_pressed("action"):
		fire()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta: float) -> void:
	pass
	
	
func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = deg_to_rad(gun_sprite.rotation_degrees)
	bullet.pos = $Gun/Sprite2D/Point.global_position
	bullet.rota = deg_to_rad(gun_sprite.global_rotation_degrees)
	get_parent().add_child(bullet)
