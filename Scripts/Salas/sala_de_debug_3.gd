extends Node2D

@onready var door_plus_level := $"Doors/StageEnd_Door1" as Node2D
@onready var door_minus_level := $"Doors/StageEnd_Door2" as Node2D

func _ready():
	door_plus_level.setup_door(9)
	door_minus_level.setup_door(5)

func _on_player_enters_plus_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/sala_de_debug_4a.tscn")

func _on_player_enters_minus_door():
	SceneSwitcher.switch_scene("res://Cenas/Salas/sala_de_debug_4b.tscn")
