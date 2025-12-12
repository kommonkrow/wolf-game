extends Node

@export var elk_scene: PackedScene
var score

func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$ElkTimer.stop()

func new_game():
	score = 0
	$WolfBody2D.start($StartPosition.position)
	$StartTimer.start()


func _on_elk_timer_timeout() -> void:
# Create a new instance of the Mob scene.
	var elk = elk_scene.instantiate()
	# Choose a random location on Path2D.
	var elk_spawn_location = $ElkPath/ElkSpawnLocation
	elk_spawn_location.progress_ratio = randf()
	# Set the mob's position to the random location.
	elk.position = elk_spawn_location.position
	
	add_child(elk)

func _on_score_timer_timeout() -> void:
	score += 1

func _on_start_timer_timeout() -> void:
	$ElkTimer.start()
	$ScoreTimer.start()
	$WolfBody2D/HungerTimer.start()
