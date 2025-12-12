extends Node

@export var elk_scene: PackedScene
var score

func game_over():
	$ScoreTimer.stop()
	$ElkTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
