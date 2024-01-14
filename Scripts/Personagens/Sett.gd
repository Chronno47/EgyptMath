extends Personagens_Gerais
class_name Jogador

const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

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
	
	##LEMBRA DE ADICIONAR UM IDLE PRA MOEDA + RESOLVER O PROBLEMA DE INVERSAO DELA
	if InteractionManager.holding_coin():
		match InteractionManager.coin_value:
			1:
				state = "IdleCoin1"
			2:
				state = "IdleCoin2"
			3:
				state = "IdleCoin3"
			4:
				state = "IdleCoin4"
			5:
				state = "IdleCoin5"
			6:
				state = "IdleCoin6"
			7:
				state = "IdleCoin7"
			8:
				state = "IdleCoin8"
			9:
				state = "IdleCoin9"
		if !is_on_floor():
			match InteractionManager.coin_value:
				1:
					state = "FallingCoin1"
				2:
					state = "FallingCoin2"
				3:
					state = "FallingCoin3"
				4:
					state = "FallingCoin4"
				5:
					state = "FallingCoin5"
				6:
					state = "FallingCoin6"
				7:
					state = "FallingCoin7"
				8:
					state = "FallingCoin8"
				9:
					state = "FallingCoin9"
		elif direction != 0:
			match InteractionManager.coin_value:
				1:
					state = "RunningCoin1"
				2:
					state = "RunningCoin2"
				3:
					state = "RunningCoin3"
				4:
					state = "RunningCoin4"
				5:
					state = "RunningCoin5"
				6:
					state = "RunningCoin6"
				7:
					state = "RunningCoin7"
				8:
					state = "RunningCoin8"
				9:
					state = "RunningCoin9"
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
					
	elif !is_on_floor():
		state = "Falling"
	elif direction != 0:
		state = "Running"
	
	if animations.name != state:
		animations.play(state)
#endregion

