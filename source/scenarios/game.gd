extends Node2D
var crosshair = load("res://assets/images/crosshair.png")
var time:float;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_custom_mouse_cursor(crosshair)
	pass
	
func _process(delta: float) -> void:
	time += 1 * delta
