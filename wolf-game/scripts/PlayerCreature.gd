extends CharacterBody2D

@export var speed = 50

@onready var canMove: bool = false
var target = position

func _input(_event):
	if(canMove == true):
		look_at(get_global_mouse_position())
		# Use is_action_pressed to only accept single taps as input instead of mouse drags.
		if Input.is_action_pressed("rmb"):
			target = get_global_mouse_position()
		if Input.is_action_just_released("rmb"):
			target = position
			move_and_slide()

func _physics_process(_delta):
	velocity = position.direction_to(target) * speed * 10
	# look_at(target)
	if position.distance_to(target) > 2:
		move_and_slide()


func start(pos):
	position = pos
	show()

func _on_area_2d__bite_box_area_entered(area: Area2D):
	if area.is_in_group("HurtBox"):
		print("Bite")
