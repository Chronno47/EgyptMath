extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D

func _ready():
	stage_end_door.setup_door(2)
	
func _on_stage_end_door_player_enters_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/Salas do Jogo/divisao_level_2.tscn")
	InteractionManager.drop_item() #ele so vai resetar os items nesse caso
