extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var interaction_message := $"Interaction Message" as Label

const base_text = "[E] para "

#region Controlador de area de interação
# vai ser colocada a area mais perto e removida quando tiver outra mais perto
var active_areas: Array = []
var can_interact: bool = true
#region variaveis custom que não fazem parte do tutorial
#(custom) vai verificar se o jogador ja ta segurando uma moeda
var is_holding_coin: bool = false
var coin_value: int
#endregion

func register_area(area: InteractionArea):
	active_areas.push_back(area)

func unregister_area(area: InteractionArea):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)
#endregion

#isso aqui vai ajustar como a mensagem de interagir vai aparecer
func _process(delta):
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
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
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
			
	elif event.is_action_pressed("drop") && is_holding_coin:
		drop_item()
		holding_coin_number(0)
#endregion

#encapsulamento da variavel is_holding_item
func holding_coin():
	return is_holding_coin
	
func set_holding_coin(value: bool):
	is_holding_coin = value

func holding_coin_number(number: int):
	coin_value = number

func drop_item():
	set_holding_coin(false)
