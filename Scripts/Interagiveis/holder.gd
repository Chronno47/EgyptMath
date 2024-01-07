extends Node2D
class_name Holder

signal on_coin_placed
signal on_operator_placed

@onready var interaction_area := $"Interactable Area" as InteractionArea
const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

#vai dizer a moeda que o pedestal ta segurando no momento
var holder_current_value: int = 0
var holder_current_operator: operator = operator.NONE

var coin_on_holder: bool = false
var operator_on_holder: bool = false

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
#se o jogador interagir com o pedestal segurando uma moeda, o interaction manager desativa que o jogador
#esta segurando a moeda e atribui o valor da moeda ao pedestal, depois reseta o valor da moeda
func _on_interact():
	if InteractionManager.holding_coin():
		_handle_coin_interaction()
	elif InteractionManager.holding_operator():
		_handle_operator_interaction()


func _handle_coin_interaction():
		InteractionManager.set_holding_coin(false)
		holder_current_operator = operator.NONE
		_holder_value(InteractionManager.coin_value)
		_set_as_holding_coin()
		InteractionManager.holding_coin_number(0)
		print("holder value: ",holder_current_value)
		
func _handle_operator_interaction():
		InteractionManager.set_holding_operator(false)
		holder_current_value = 0
		_holder_operator(InteractionManager.holding_operator_type)
		InteractionManager.set_holding_operator_type(operator.NONE)
		_set_as_holding_operator()
		print("Holder operator: ", holder_current_operator)
	
func _holder_value(number:int):
	holder_current_value = number

func _holder_operator(operation):
	holder_current_operator = operation

func _set_as_holding_coin():
	operator_on_holder = false
	coin_on_holder = true
	emit_signal("on_coin_placed", holder_current_value)
	
func _set_as_holding_operator():
	coin_on_holder = false
	operator_on_holder = true
	emit_signal("on_operator_placed", holder_current_operator)
	
#inutil por enquanto
func update_holder_status():
	if coin_on_holder:
		return holder_current_value
	elif operator_on_holder:
		return holder_current_operator
