extends Node

@export var elk_scene: PackedScene
var score
var hunger: int

func _ready():
	$HUD.update_hunger(hunger)

func game_over():
	$ScoreTimer.stop()
	$ElkTimer.stop()
	$HungerTimer.stop()
	
	$HUD.show_game_over()
	$WolfBody2D.canMove = false
	
	$WolfBody2D/Music.stop()
	$WolfBody2D/DeathSound.play()

func new_game():
	get_tree().call_group("Herbivore", "queue_free")
	score = 0
	hunger = 100
	
	var elk = elk_scene.instantiate()
	# Choose a random location on Path2D.
	var elk_spawn_location = $ElkPath/ElkSpawnLocation
	elk_spawn_location.progress_ratio = randf()
	# Set the mob's position to the random location.
	elk.position = elk_spawn_location.position
	add_child(elk)
	
	$WolfBody2D.start($StartPosition.position)
	$ElkTimer.start()
	$StartTimer.start()
	
	$HUD.update_score(score)
	$HUD.update_hunger(hunger)
	$HUD.show_message("Happy Hunting!")
	
	$WolfBody2D/Music.play()


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
	score += 2
	$HUD.update_score(score)

func handle_elk_death():
	score += 10
	$HUD.update_score(score)
	if hunger < 89:
		hunger += 10
		$HUD.update_hunger(hunger)
	elif hunger > 90:
		hunger = 100
		$HUD.update_hunger(hunger)

func _on_start_timer_timeout() -> void:
	$WolfBody2D.canMove = true
	
	$ScoreTimer.start()
	$HungerTimer.start()


func _on_hunger_timer_timeout() -> void:
	hunger -= 2
	$HUD.update_hunger(hunger)
	if hunger < 1:
		game_over()
