extends StaticBody2D

@onready var top_collision := $"LadderTop_Collision" as CollisionShape2D

const INPUT_DOWN = "down"

var is_above_ladder:bool = false

#rotacionar a colisão pra verificar de onde o player ta vindo em relação a plataforma
func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed(INPUT_DOWN) && is_above_ladder:
		top_collision.rotation_degrees = 180
	else:
		top_collision.rotation_degrees = 0

func _on_above_checker_body_entered(_body: Node2D) -> void:
	is_above_ladder = true


func _on_above_checker_body_exited(_body: Node2D) -> void:
	is_above_ladder = false
