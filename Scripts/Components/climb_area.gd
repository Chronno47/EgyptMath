extends Area2D

const INPUT_UP = "up"
const INPUT_DOWN = "down"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") && !InteractionManager.holding_coin() && !InteractionManager.holding_operator():
		if !body.is_climbing:
			body.is_climbing = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.is_climbing:
			body.is_climbing = false
