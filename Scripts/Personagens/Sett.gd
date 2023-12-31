extends Personagens_Gerais
class_name Jogador

signal game_over

@export var jump_force: float = -200.0
var direction
var is_holding_coin: bool = false

const MAX_HEALTH = 6
var player_health = 6

#region Controles
const INPUT_UP = "up"
const INPUT_LEFT = "left"
const INPUT_DOWN = "down"
const INPUT_RIGHT = "right"
const INPUT_JUMP = "jump"
#endregion

#referenciando as variaveis com os nós
@onready var animations := $"Animações" as AnimatedSprite2D

#region Parte de movimentação do jogador
func _physics_process(delta):
	# Gravidade
	if !is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed(INPUT_JUMP) and is_on_floor():
		velocity.y = jump_force

	direction = Input.get_axis(INPUT_LEFT, INPUT_RIGHT)
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
	elif direction != 0:
		state = "Running"
	
	if animations.name != state:
		animations.play(state)
#endregion

