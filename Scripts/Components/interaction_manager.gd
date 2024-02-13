extends Node2D

#player info pega uma instancia do singleton que armazena a posição do jogado PRO JOGO NAO CRASHAR
@onready var player_info := preload("res://Scripts/Components/player_info.gd").new()
@onready var interaction_message := $"Interaction Message" as Label

const base_text = "[E] para "

#region Controlador de area de interação
# vai ser colocada a area mais perto e removida quando tiver outra mais perto
var active_areas: Array = []
var can_interact: bool = true
#region variaveis custom que não fazem parte do tutorial
#(custom) vai verificar se o jogador ja ta segurando uma moeda/operador
var is_holding_coin: bool = false
var is_holding_operator: bool = false
#(custom) numero da moeda/tipo de operacao
var coin_value: int

enum OperatorType
{
	ADICAO = 100,
	SUBTRACAO = 200,
	MULTIPLICACAO = 300,
	DIVISAO = 400,
	NONE = 500,
}
var holding_operator_type: OperatorType
#endregion

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
#endregion

#isso aqui vai ajustar como a mensagem de interagir vai aparecer
func _process(_delta):
	if active_areas.size() > 0 && can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		interaction_message.text = base_text + active_areas[0].action_name
		interaction_message.global_position = active_areas[0].global_position
		interaction_message.global_position.y -= 36
		interaction_message.global_position.x -= interaction_message.size.x / 2
		interaction_message.show()
	else:
		interaction_message.hide()
		
func _sort_by_distance_to_player(area1, area2):
	#substituido .distance_to()  pelo distance_squared_to
	var area1_to_player = player_info.player_position.distance_squared_to(area1.global_position)
	var area2_to_player = player_info.player_position.distance_squared_to(area2.global_position)
	return area1_to_player < area2_to_player
	
#verifica o que acontece quando o jogador pressiona o butao de interagir
#se tiver na area de interação ele aciona, se nao então n faz nada
#se a tecla de drop for pressionada ele diz que n ta mais segurando item
#qualquer coisa substitui input por event
func _input(event):
	if event.is_action_pressed("Interact") && can_interact:
		if active_areas.size() > 0:
			can_interact = false
			interaction_message.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
			
	elif event.is_action_pressed("drop"):
		if holding_coin() || holding_operator():
			drop_item()
			holding_coin_number(0)
			set_holding_operator_type(OperatorType.NONE)
#endregion

#region varias funcoes pra definição de estados
func holding_coin():
	return is_holding_coin
	
func set_holding_coin(value: bool):
	is_holding_coin = value

func holding_coin_number(number: int):
	coin_value = number
	
func holding_operator():
	return is_holding_operator
	
func set_holding_operator(value:bool):
	is_holding_operator = value
	
func set_holding_operator_type(type: OperatorType):
	holding_operator_type = type

func drop_item():
	set_holding_coin(false)
	set_holding_operator(false)
	
#endregion
