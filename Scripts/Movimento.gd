extends CharacterBody2D

const SPEED = 100.0
const JUMP_FORCE = -200.0
var direction
var is_player_afk = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animations := $"Animações" as AnimatedSprite2D
@onready var standby_timer := $"Standby Timer" as Timer

func _physics_process(delta):
	# Gravidade
	if !is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		animations.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	_set_state()
	move_and_slide()

func _set_state():
	var state = "Idle"

	if !is_on_floor():
		state = "Falling"
	elif direction != 0:
		state = "Running"
	
	if animations.name != state:
		animations.play(state)




