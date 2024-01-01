extends Node2D

@onready var interaction_area := $"Interactable Area" as InteractionArea

#vai dizer a moeda que o pedestal ta segurando no momento
var holder_current_value: int = 0

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
#se o jogador interagir com o pedestal segurando uma moeda, o interaction manager desativa que o jogador
#esta segurando a moeda e atribui o valor da moeda ao pedestal, depois reseta o valor da moeda
func _on_interact():
	if InteractionManager.holding_coin():
		InteractionManager.set_holding_coin(false)
		holder_value(InteractionManager.coin_value)
		InteractionManager.holding_coin_number(0)
		print("holder value: ",holder_current_value)

func holder_value(number:int):
	holder_current_value = number
