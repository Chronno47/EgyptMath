extends Node

@onready var player_position := Vector2(0,0) 
@onready var current_level

func update_player_position(position: Vector2):
	player_position = position
	var root = get_tree().root
	current_level = root.get_child(root.get_child_count() - 1)
	
func update_player_current_level():
	pass
