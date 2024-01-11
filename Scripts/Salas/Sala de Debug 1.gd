extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D
var next_scene = load("res://Cenas/Salas/sala_de_debug_2.tscn")

func _ready():
	stage_end_door.setup_door(3)

func _on_player_enters_door():
	get_tree().change_scene_to_packed(next_scene)
