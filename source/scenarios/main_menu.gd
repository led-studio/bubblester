class_name MainMenu
extends Control

@onready var play_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Button as Button
@onready var credits_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Credits_Button as Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var credits_menu: CreditsMenu = $Credits_Menu as CreditsMenu
@onready var margin_container: MarginContainer = $MarginContainer as MarginContainer

@onready var start_level = preload("res://source/scenarios/game.tscn") as PackedScene

func _ready():
	handle_connecting_signals()


func on_play_pressed() -> void: 
	Transition.change_scene("res://source/scenarios/game.tscn")


func on_credits_pressed() -> void: 
	margin_container.visible = false
	credits_menu.set_process(true)
	credits_menu.visible = true 


func on_exit_pressed() -> void: 
	get_tree().quit()


func on_exit_credits_menu() -> void:
	margin_container.visible = true
	credits_menu.visible = false


func handle_connecting_signals() -> void:
	play_button.button_down.connect(on_play_pressed)
	credits_button.button_down.connect(on_credits_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	credits_menu.exit_Credits_Menu.connect(on_exit_credits_menu)
