extends Area2D

export var xSpeed: float = -50.0

func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	move_local_x(xSpeed * delta)
	if position.x < 50:
		queue_free()
