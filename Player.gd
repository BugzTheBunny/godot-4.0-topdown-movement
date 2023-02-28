extends CharacterBody2D

@export var speed := 80.0
@export var starting_direction := Vector2(0,1)
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.set("parameters/Idle/blend_position",starting_direction)

func _physics_process(delta):
	var movement_vector = Input.get_vector("left", "right", "up", "down")
	if movement_vector != Vector2.ZERO:
		animation_tree.set("parameters/Run/blend_position",movement_vector)
		animation_tree.set("parameters/Idle/blend_position",movement_vector)
		state_machine.travel("Run")
	else:
		state_machine.travel("Idle")
				
	velocity = movement_vector.normalized() * speed
	move_and_slide()
