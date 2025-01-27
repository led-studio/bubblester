extends Area2D

var type_gun
var random = randi() % 2

func _ready() -> void:
	if random == 1:
		$AnimatedSprite2D.play("moskete")
		type_gun = 1
	else:
		$AnimatedSprite2D.play("machinegun")
		type_gun = 2
func _process(delta: float) -> void:
	position.y -= 1 * delta * 100

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_gun"):
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		body.change_gun(type_gun)
		queue_free()
