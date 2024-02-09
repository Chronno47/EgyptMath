extends Node

@onready var player_position := Vector2(0,0) 
static var previous_scene_path = ""

func update_player_position(position: Vector2):
	player_position = position
