extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D

func _on_stage_end_door_player_enters_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/Salas do Jogo/seshat_room.tscn")
	InteractionManager.drop_item() #ele so vai resetar os items nesse caso
