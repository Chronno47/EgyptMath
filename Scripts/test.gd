extends Node2D

@onready var interaction_area := $"Interactable Area" as InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if !InteractionManager.holding_coin():
		InteractionManager.set_holding_coin(true)
		InteractionManager.holding_coin_number(6)
		print(InteractionManager.coin_value)
