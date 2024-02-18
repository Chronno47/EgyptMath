extends Node2D

#vai ser usado pra poder abrir a porta, isso pra impedir que o jogador n saia sem ter pego o artefato
signal artifact_collected

@onready var interaction_area := $"Interactable Area" as InteractionArea

func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	ArtifactInfo.player_collected_artifact("Amonra_Artifact")
	artifact_collected.emit()
	queue_free()
