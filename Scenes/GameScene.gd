extends Node2D

var BlockOne = preload("res://Actors/BlockOne.tscn")
var BlockTwo = preload("res://Actors/BlockTwo.tscn")
var BlockThree = preload("res://Actors/BlockThree.tscn")
var BlockFour = preload("res://Actors/BlockFour.tscn")

var blockArray = [BlockOne, BlockTwo, BlockThree, BlockFour]

var time = 0
var nextTime = 0
var spawnBlocks = false
var score: int = 0
export var frequency = 0.5
var restart: bool = true

func _ready() -> void:
	get_node("InGameScore/Label").visible = false
	get_node("EndGameMenu").visible = false

func _process(delta: float) -> void:
	if not spawnBlocks:
		get_input()
		return
	time += delta
	if time > nextTime:
		var nextBlockIndex = int(floor(rand_range(0, 4)))
		nextTime += 1 / frequency
		var block = blockArray[nextBlockIndex].instance()
		block.position.x = 720 - (block.xSpeed * (time - nextTime))
		block.add_to_group("blocks")
		add_child(block)

func _on_Square_death() -> void:
	spawnBlocks = false
	get_node("SkyBackground/SkyParallaxLayer").set_process(false)
	for child in get_children():
		if child.is_in_group("blocks"):
			child.queue_free()

func _on_Square_finish_death() -> void:
	get_node("EndGameMenu/EndGameScore").text += "\n" + str(score)
	get_node("InGameScore/Label").visible = false
	get_node("EndGameMenu").visible = true

func _on_Square_start() -> void:
	spawnBlocks = true
	get_node("titletext").visible = false
	get_node("InGameScore/Label").visible = true

func _on_Square_score() -> void:
	score += 1
	get_node("InGameScore/Label").text = str(score)

func get_input():
	if Input.is_action_just_pressed("endgame_down") and restart:
		restart = false
		get_node("EndGameMenu/selected").position.y = 410
	elif Input.is_action_just_pressed("endgame_up") and not restart:
		restart = true
		get_node("EndGameMenu/selected").position.y = 310
	elif Input.is_action_just_pressed("jump"):
		get_tree().reload_current_scene()