extends Area2D

@onready var interaction_area := $"Interactable Area" as InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

# se o jogador n tiver segurando nada, ele limpa o item da arvore e diz que o jogador ta segurando item
func _on_interact():
	if !InteractionManager.holding_item():
		queue_free()
		InteractionManager.set_holding_item(true)
