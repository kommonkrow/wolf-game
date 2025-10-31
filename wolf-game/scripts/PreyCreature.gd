extends CharacterBody2D

var preyHealth: int = 3
var maxHealth


func _on_awareness__elk_area_entered(area: Area2D) -> void:
	if area.is_in_group("Carnivore"):
		print("Carnivore detected.")

#func flee_predator():
	#direction = (predator.position + position).normalized()
	#position += direction * speed
	##switch to Timer timeout!!!!!!!!
	#if position.distance_to(predator.position) > 100:
		#current_state = State.WANDER
		

# ~~ TAKE DAMAGE ~~ #
func _on_hit_box__elk_whole_body_area_entered(area: Area2D):
	if area.is_in_group("HitBox"):
		if preyHealth > 0:
			print("Prey Hit")
			preyHealth -= 1
			var preyHealthString = "Prey health = %s" % preyHealth
			print(preyHealthString)
		if preyHealth < 1:
			self.queue_free()
			print("Prey destroyed.")
