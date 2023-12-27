extends Personagens_Gerais
class_name Jogador

signal game_over

@export var jump_force: float = -200.0
var direction

const MAX_HEALTH = 6
var player_health = 6

#referenciando as variaveis com os nós
@onready var animations := $"Animações" as AnimatedSprite2D
@onready var standby_timer := $"Standby Timer" as Timer


#region Parte de movimentação do jogador
func _physics_process(delta):
	# Gravidade
	if !is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

	direction = Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * move_speed
		animations.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)

	_set_state()
	move_and_slide()
#endregion

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
