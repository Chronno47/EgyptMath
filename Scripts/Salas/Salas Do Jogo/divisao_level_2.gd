extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D

func _ready():
	stage_end_door.setup_door(1)
	
func _on_stage_end_door_player_enters_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/Salas do Jogo/amonra_artifact_room.tscn")
	InteractionManager.drop_item() #ele so vai resetar os items nesse caso
