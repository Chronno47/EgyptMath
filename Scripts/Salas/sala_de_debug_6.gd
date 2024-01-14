extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D

func _ready():
	stage_end_door.setup_door(36)
	
func _on_player_enters_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/sala_de_debug_7.tscn")
