extends Personagens_Gerais

@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var wall_detector := $"Wall_Detector" as RayCast2D
@onready var ground_detector := $"Ground_Detector" as RayCast2D

var snake_health:int = 1

var direction := -1

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		
	if wall_detector.is_colliding():
		_switch_direction()
	
	if !ground_detector.is_colliding():
		_switch_direction()
	
	velocity.x = direction * (move_speed * 0.60)
	animations.scale.x = -direction
	
	_set_state()
	move_and_slide()

func _switch_direction():
		direction *= -1
		wall_detector.scale.x *= -1

func take_damage(damage:int):
	print("snake toke damage")
	snake_health -= damage
	if snake_health <= 0:
		queue_free()

func _set_state():
	var state = "Idle"
	
	if direction != 0:
		state = "Slithering"
		
	animations.play(state)
