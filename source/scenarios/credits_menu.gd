class_name CreditsMenu 
extends Control

@onready var exit: Button = $MarginContainer/VBoxContainer/exit as Button

signal exit_Credits_Menu

func _ready() -> void:
	exit.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_Credits_Menu.emit()
	set_process(false)
