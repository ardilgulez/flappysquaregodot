extends ParallaxLayer

export var parallaxSpeed: float = 100.0

func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	move_local_x(-1 * parallaxSpeed * delta)