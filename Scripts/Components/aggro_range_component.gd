extends Area2D

signal player_in_range(new_direction)
signal player_exits_range

func _on_body_entered(body: Node2D) -> void:
	player_in_range.emit(body.global_position.x - self.global_position.x)

func _on_body_exited(body: Node2D) -> void:
	player_exits_range.emit()
