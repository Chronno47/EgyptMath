extends Personagens_Gerais
class_name Projectile

@onready var hit_on_left := $"Raycasts/Hit_Detector_Left" as RayCast2D
@onready var hit_on_right := $"Raycasts/Hit_Detector_Right" as RayCast2D

var direction := 1

func _physics_process(delta: float):
	if hit_on_left.is_colliding() || hit_on_right.is_colliding():
		queue_free()
	
	position.x += (move_speed * 0.60) * direction * delta
	
func set_direction(new_direction):
	direction = new_direction
