extends Area2D

@onready var interaction_area: InteractionArea = $"Interactable Area"

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	pass
