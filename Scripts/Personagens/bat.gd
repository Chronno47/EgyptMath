extends Personagens_Gerais

@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var wall_detector := $"Wall_Detector" as RayCast2D

var health:int = 1
var direction := -1

func _physics_process(_delta: float) -> void:
	
	if wall_detector.is_colliding():
		_switch_direction()
	
	velocity.x = direction * (move_speed * 0.60)
	animations.scale.x = -direction
	
	_set_state()
	move_and_slide()

func _switch_direction():
		direction *= -1
		wall_detector.scale.x *= -1

func take_damage(damage:int):
	health -= damage
	if health <= 0:
		queue_free()

func _set_state():
	var state = "Flying"
	
	animations.play(state)
