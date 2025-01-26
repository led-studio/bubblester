extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func change_scene(target:String):
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("fade_out")

func restart()->void:
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play("fade_out")
