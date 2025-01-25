extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if DisplayServer.mouse_get_mode() == DisplayServer.MOUSE_MODE_VISIBLE:
		DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	pass # Replace with function body.
