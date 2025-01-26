class_name MainMenu
extends Control

@onready var play_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Button as Button
@onready var credits_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var start_level = preload("res://source/scenarios/game.tscn") as PackedScene

func _ready():
	play_button.button_down.connect(on_play_pressed)
	exit_button.button_down.connect(on_exit_pressed)

func on_play_pressed() -> void: 
	Transition.change_scene("res://source/scenarios/game.tscn")

func on_credits_pressed() -> void: 
	pass

func on_exit_pressed() -> void: 
	get_tree().quit()
