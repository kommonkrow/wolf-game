extends CharacterBody2D

enum PREY_STATE { IDLE, WANDER, FLEE }

@export var moveSpeed: float = 100
@export var idleTime: float = 5
@export var wanderTime: float = 10

@onready var timer = $Timer
@onready var awareness = $"Awareness - Elk/CollisionShape2D"
@onready var activePredator: Vector2 = get_node("/root/Game/WolfBody2D").position

var moveDirection: Vector2 = Vector2.ZERO
var currentState: PREY_STATE = PREY_STATE.IDLE

var preyHealth: int = 3
var maxHealth

func _ready():
	pick_new_state()

func _physics_process(_delta):
	if(currentState == PREY_STATE.WANDER):
		velocity = moveDirection * moveSpeed
		
		move_and_slide()
	if(currentState == PREY_STATE.FLEE):
		moveSpeed = 0.15
		moveDirection = Vector2(activePredator.x + position.x, activePredator.y + position.y)
		velocity = moveDirection * moveSpeed
		
		move_and_slide()

func select_new_direction():
	moveDirection = Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	)
	

func _on_awareness__elk_area_entered(area: Area2D) -> void:
	if area.is_in_group("Carnivore"):
		print("Carnivore detected.")
		
		currentState = PREY_STATE.FLEE
		flee_from_predator()

func flee_from_predator():
	print("Fleeing.")
	pass

func pick_new_state():
	if(currentState == PREY_STATE.IDLE):
		print("Wandering.")
		select_new_direction()
		currentState = PREY_STATE.WANDER
		timer.start(wanderTime)
	elif(currentState == PREY_STATE.WANDER):
		print("Idling.")
		currentState = PREY_STATE.IDLE
		timer.start(idleTime)

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


func _on_timer_timeout() -> void:
	if(currentState != PREY_STATE.FLEE):
		pick_new_state()
	elif(currentState == PREY_STATE.FLEE):
		currentState = PREY_STATE.WANDER
