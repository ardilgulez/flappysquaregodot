extends KinematicBody2D

export var gravity: float = 40.0
export var ySpeed: float = -80.0

var velocity: Vector2 = Vector2(0, ySpeed)

var started: bool = false
var dead: bool = false

signal death

func _ready() -> void:
	pass # Replace with function body.

func input_process() -> void:
	if Input.is_action_pressed("jump") and not dead:
		started = true
		if position.y < 0:
			velocity = Vector2.ZERO
		else:
			velocity = Vector2(0, ySpeed)

func _physics_process(delta: float) -> void:
	input_process()
	velocity = move_and_slide(velocity)
	if dead and position.y > 688:
		velocity = Vector2.ZERO
	else:
		velocity.y += (gravity * delta)

func _on_BlockChecker_area_entered(area: Area2D) -> void:
	emit_signal("death")
	velocity = Vector2(0, -ySpeed)
	dead = true
	started = false
	