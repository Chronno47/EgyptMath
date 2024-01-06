extends Node2D
class_name Holder

@onready var interaction_area := $"Interactable Area" as InteractionArea
const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

#vai dizer a moeda que o pedestal ta segurando no momento
var holder_current_value: int = 0
var holder_current_operator: operator = operator.NONE

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
		InteractionManager.holding_coin_number(0)
		print("holder value: ",holder_current_value)
		
func _handle_operator_interaction():
		InteractionManager.set_holding_operator(false)
		holder_current_value = 0
		_holder_operator(InteractionManager.holding_operator_type)
		InteractionManager.set_holding_operator_type(operator.NONE)
		print("Holder operator: ", holder_current_operator)
	
func _holder_value(number:int):
	holder_current_value = number

func _holder_operator(operation):
	holder_current_operator = operation
