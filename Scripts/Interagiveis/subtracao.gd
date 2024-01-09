extends Node2D

@onready var interaction_area := $"Interactable Area" as InteractionArea
const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	if !InteractionManager.holding_operator() && !InteractionManager.holding_coin():
		InteractionManager.set_holding_operator(true)
		InteractionManager.set_holding_operator_type(operator.SUBTRACAO)
