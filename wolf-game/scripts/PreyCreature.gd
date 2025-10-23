extends CharacterBody2D

var preyHealth = 10
var maxHealth

#var predator = position

#func DetectPredator():
#Detect collision with Awareness by PlayerCreature

#func FleeFromPredator():
#Get location of predator 

#Move away from predator

#func GoIdle():
	

#func IdleWander():
	


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
