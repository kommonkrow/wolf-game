extends CharacterBody2D

@export var speed = 40

signal hunger_timeout

var target = position
@onready var hunger = $HungerTimer

func _input(_event):
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
	if position.distance_to(target) > 5:
		move_and_slide()

func _process(delta):
	pass

func start(pos):
	position = pos
	show()

func _on_area_2d__bite_box_area_entered(area: Area2D):
	if area.is_in_group("HurtBox"):
		print("Bite")


func _on_hunger_timer_timeout() -> void:
	hide()
	hunger_timeout.emit()
