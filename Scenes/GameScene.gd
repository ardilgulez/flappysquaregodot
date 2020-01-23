extends Node2D

var BlockOne = preload("res://Actors/BlockOne.tscn")
var BlockTwo = preload("res://Actors/BlockTwo.tscn")
var BlockThree = preload("res://Actors/BlockThree.tscn")
var BlockFour = preload("res://Actors/BlockFour.tscn")

var blockArray = [BlockOne, BlockTwo, BlockThree, BlockFour]

var time = 0
var nextTime = 0
export var frequency = 0.5

func _process(delta: float) -> void:
	time += delta
	if time > nextTime:
		var nextBlockIndex = int(floor(rand_range(0, 4)))
		nextTime += 1 / frequency
		var block = blockArray[nextBlockIndex].instance()
		block.position.x = 1380 - (block.xSpeed * time - nextTime)
		block.add_to_group("blocks")
		add_child(block)

func _on_Square_death() -> void:
	for child in get_children():
		if child.is_in_group("blocks"):
			child.queue_free()

func _on_Square_finish_death() -> void:
	get_tree().change_scene("res://Scenes/EndGame.tscn")
