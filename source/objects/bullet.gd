extends CharacterBody2D


var pos:Vector2
var rota:float
var dir:float
var speed = 200
var random;

func _ready() -> void:
	global_position = pos
	global_rotation = rota
	random = randi() % 2
	print(random)
	match random:
		0:
			$AnimatedSprite2D.play("first")
		1:
			$AnimatedSprite2D.play("second")
		2:
			$AnimatedSprite2D.play("third")
	
func _physics_process(delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(dir)
	move_and_slide()


func _on_life_timeout() -> void:
	queue_free()
	pass # Replace with function body.
