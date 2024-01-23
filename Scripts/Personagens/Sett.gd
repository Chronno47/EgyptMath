extends Personagens_Gerais
class_name Jogador

const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

signal game_over

@export var jump_force: float = -200.0
var direction
var is_holding_coin: bool = false
var is_climbing:bool = false
@export var climbing_speed:float = 50.0

const MAX_HEALTH:int = 3
@export var player_health:int = 3

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
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if is_climbing:
		velocity.y = 0
		if Input.is_action_pressed(INPUT_UP):
			velocity.y = -climbing_speed
		elif Input.is_action_pressed(INPUT_DOWN):
			velocity.y = climbing_speed
	
	# Handle jump.
	if Input.is_action_just_pressed(INPUT_JUMP) && is_on_floor():
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

#region Script de animação, da uma otimizada na parte de operadores
func _set_state():
	var state = "Idle"
	
	##LEMBRA DE RESOLVER O PROBLEMA DE INVERSAO DA MOEDA
	if InteractionManager.holding_coin():
		state = "IdleCoin%d" % InteractionManager.coin_value
		if !is_on_floor():
			state = "FallingCoin%d" % InteractionManager.coin_value
		elif direction != 0:
			state = "RunningCoin%d" % InteractionManager.coin_value
			
	elif InteractionManager.holding_operator():
		match InteractionManager.holding_operator_type:
			operator.ADICAO:
				state = "IdleAdicao"
			operator.SUBTRACAO:
				state = "IdleSubtracao"
			operator.MULTIPLICACAO:
				state = "IdleMultiplicacao"
			operator.DIVISAO:
				state = "IdleDivisao"
		if !is_on_floor():
			match InteractionManager.holding_operator_type:
				operator.ADICAO:
					state = "FallingAdicao"
				operator.SUBTRACAO:
					state = "FallingSubtracao"
				operator.MULTIPLICACAO:
					state = "FallingMultiplicacao"
				operator.DIVISAO:
					state = "FallingDivisao"
		elif direction != 0:
			match InteractionManager.holding_operator_type:
				operator.ADICAO:
					state = "RunningAdicao"
				operator.SUBTRACAO:
					state = "RunningSubtracao"
				operator.MULTIPLICACAO:
					state = "RunningMultiplicacao"
				operator.DIVISAO:
					state = "RunningDivisao"
					
	elif is_climbing:
		state = "Climbing"
	elif !is_on_floor():
		state = "Falling"
	elif direction != 0:
		state = "Running"
	
	if animations.name != state:
		animations.play(state)
#endregion

