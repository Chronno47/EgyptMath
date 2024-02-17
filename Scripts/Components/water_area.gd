extends Area2D

signal on_water(is_on_water:bool)

	
func _on_body_entered(_body: Node2D) -> void:
	on_water.emit(true)
func _on_body_exited(_body: Node2D) -> void:
	on_water.emit(false)
