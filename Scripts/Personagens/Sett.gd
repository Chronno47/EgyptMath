extends Personagens_Gerais
class_name Jogador

const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

#tentar usar esse signal depois
signal game_over

@export var jump_force: float = -200.0
var player_speed:float = move_speed
var knockback_vector := Vector2.ZERO
var knockback_duration:float = 0.25
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

func _ready():
	SceneSwitcher.scene_switched.connect(_on_scene_switched)

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
		velocity.x = direction * player_speed
		animations.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
	
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
		state = "Climbing_Idle"
		if is_climbing && Input.is_action_pressed(INPUT_UP) || Input.is_action_pressed(INPUT_DOWN):
			state = "Climbing"
	elif !is_on_floor():
		state = "Falling"
	elif direction != 0:
		state = "Running"
	
	if animations.name != state:
		animations.play(state)
#endregion

#feedback ao dar dano
func _on_hitbox_component_body_entered(_body: Node2D):
	velocity.y = jump_force

func take_damage(amount):
	var knockback_force = Vector2(200,-200)
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, knockback_duration)
		animations.modulate = Color("Red")
		knockback_tween.parallel().tween_property(animations, "modulate", Color("White"), knockback_duration)
		
	var old_hp = player_health
	player_health -= amount
	UiOnScreen.emit_signal("health_changed", old_hp, player_health, MAX_HEALTH)
	
	if player_health <= 0:
		_on_player_death()

func _on_water_area_on_water(is_on_water:bool):
	if is_on_water:
		player_speed *= 0.50
	else:
		player_speed = move_speed

func _on_player_death():
	#teve um trabalhinho pra achar isso, mas agora ele pega o caminho do res, em vez da arvore
	PlayerInfo.previous_scene_path = get_tree().current_scene.scene_file_path
	print(PlayerInfo.previous_scene_path)
	SceneSwitcher.switch_scene("res://Cenas/Interface/game_over_screen.tscn")

func _on_scene_switched():
	SaveManager.save_game_scene(get_tree().current_scene.scene_file_path)
