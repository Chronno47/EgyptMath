extends Node2D

@onready var interaction_area := $"Interactable Area" as InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if !InteractionManager.holding_item():
		queue_free()
		InteractionManager.set_holding_item(true)
