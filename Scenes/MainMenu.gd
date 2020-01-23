extends Control


func _ready() -> void:
	pass # Replace with function body.

func get_input() -> void:
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://Scenes/GameScene.tscn")

func _process(delta: float) -> void:
	get_input()