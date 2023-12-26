extends CharacterBody2D

const SPEED = 100.0
const JUMP_FORCE = -200.0
var direction

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

#region Script de animação que eu to tentando terminar, se n der vo ter que remover o timer...
func _set_state():
	var state = "Idle"

	if !is_on_floor():
		state = "Falling"
		_reset_standy_timer()	
	elif direction != 0:
		state = "Running"
		_reset_standy_timer()	
	elif standby_timer.is_stopped():
		state = "Standby"
	else:
		_reset_standy_timer()	
	
	
	if animations.animation != state:
		animations.play(state)

func _on_standby_timer_ready():
	pass # Replace with function body.

func _reset_standy_timer():
	standby_timer.stop()
	standby_timer.start()

func _on_standby_timer_timeout():
	print("Standby timer timeout!")

#endregion
