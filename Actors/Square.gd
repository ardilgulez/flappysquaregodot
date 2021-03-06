extends KinematicBody2D

export var gravity: float = 40.0
export var ySpeed: float = -80.0
export var deathSpeed: float = 800

var velocity: Vector2 = Vector2(0, ySpeed)

var started: bool = false
var dead: bool = false
var finishDead: bool = false

signal death
signal finish_death
signal start
signal score

func _ready() -> void:
	pass # Replace with function body.

func input_process() -> void:
	if Input.is_action_just_pressed("jump") and not dead:
		if not started:
			started = true
			emit_signal("start")
		if position.y < 0:
			velocity = Vector2.ZERO
		else:
			velocity = Vector2(0, ySpeed)

func _physics_process(delta: float) -> void:
	input_process()
	if not started or finishDead:
		return
	velocity = move_and_slide(velocity)
	if dead and not finishDead:
		emit_signal("death")
		if position.y > 688:
			velocity = Vector2.ZERO
			emit_signal("finish_death")
			finishDead = true
		else:
			velocity = Vector2(0, deathSpeed)
	else:
		velocity.y += (gravity * delta)

func _on_BlockChecker_area_entered(area: Area2D) -> void:
	velocity = Vector2(0, -ySpeed)
	dead = true


func _on_ScoreChecker_area_entered(area: Area2D) -> void:
	if not dead:
		emit_signal("score")
