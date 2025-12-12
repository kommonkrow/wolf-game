extends Node

@export var elk_scene: PackedScene
var score

func _ready():
	pass

func game_over():
	$ScoreTimer.stop()
	$ElkTimer.stop()
	
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("Herbivore", "queue_free")
	score = 0
	$WolfBody2D.start($StartPosition.position)
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready!")


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
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$ElkTimer.start()
	$ScoreTimer.start()
	$WolfBody2D/HungerTimer.start()
