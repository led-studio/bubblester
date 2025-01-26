extends Node2D
var crosshair = load("res://assets/images/crosshair.png")
var time:float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(crosshair)
	pass
	
func _process(delta: float) -> void:
	time += 1 * delta
	time = snapped(time, 0.01)

	if time == 5.0:
		$Player.change_gun(1)
		$World/Spawner.spawn()
		print("Enemigo de prueba")
	elif time == 10.0:
		$Player.change_gun(2)
		Global.increase_difficulty()
	elif time == 30.0:
		Global.increase_difficulty()
		
func generate_random_enemy():
	var random = randi() % 10 - Global.difficultyMultiplayer
	if random == 1.0:
		$World/Spawner.spawn()
	pass

func _on_spawn_time_timeout() -> void:
	generate_random_enemy()
	pass # Replace with function body.
