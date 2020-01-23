extends Control

var restart: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_input() -> void:
	if Input.is_action_just_pressed("endgame_down") and restart:
		restart = false
		get_node("VBoxContainer/selected").position.y = 405.0
	elif Input.is_action_just_pressed("endgame_up") and not restart:
		restart = true
		get_node("VBoxContainer/selected").position.y = 305.0
	elif Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://Scenes/GameScene.tscn")

func _process(delta: float) -> void:
	get_input()