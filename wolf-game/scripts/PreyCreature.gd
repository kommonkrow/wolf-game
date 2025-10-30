extends CharacterBody2D

var preyHealth: int = 10
var maxHealth

var activePredator = position
signal isFleeing()
var max_contacts_reported: int

# signal set_max_contacts_reported(value: int)
var contact_collision_pos: Vector2

#--------- PREY MOVEMENT -----------#

# ~~ IDLE MOVEMENT ~~ #

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)

#func IdleWander():
	#if isFleeing = false:
		#pick random vector2
		#move in direction of vector2 for X seconds
		#idle in place for x seconds
		#repeat


#func _integrate_forces( state ):
#	if(state.get_contact_count() >= 1):  #this check is needed or it will throw errors 
#		contact_collision_pos = state.get_contact_collider_pos()

# ~~ FLEEING ~~ #

func _on_awareness__elk_area_entered(area: Area2D) -> void:
	#Detect collision with Awareness by PlayerCreature
	if area.is_in_group("Carnivore"):
		var collision_position = contact_collision_pos + get_position_delta()
		print("Contact collision: %s" % contact_collision_pos)
#		area.global_position = activePredator
#		print("activePredator = %s" % activePredator)
		isFleeing.emit(true)
		

func FleeFromPredator(activePredator):
	#check isFleeing
	if isFleeing:
		print("Running isFleeing from predator")
		
	print("activePredator = %s" % activePredator)
#Get location of predator 

#Move away from predator

#func GoIdle():
	

#--------- PREY BEHAVIOR -----------#

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
