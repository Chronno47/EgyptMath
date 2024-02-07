extends Personagens_Gerais

@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var wall_detector := $"Wall_Detector" as RayCast2D
@onready var ground_detector := $"Ground_Detector" as RayCast2D

var is_climbing_wall:bool = false

var health:int = 3

var direction := -1

func _physics_process(delta: float) -> void:
	if !is_on_floor() && !is_climbing_wall:
		velocity.y += gravity * delta
	
	if ground_detector.is_colliding && !is_climbing_wall:
		velocity.x = direction * (move_speed * 0.60)
		animations.scale.x = direction
	
	if is_climbing_wall:
		_climb_wall()
	
	if wall_detector.is_colliding():
		is_climbing_wall = true

	
	if !ground_detector.is_colliding():
		_switch_direction()
	
	_set_state()
	move_and_slide()

func _climb_wall():
	velocity.y = direction * (move_speed * 0.60)

func _switch_direction():
	direction *= -1
	wall_detector.scale.x *= -1

func take_damage(damage:int):
	health -= damage
	if health <= 0:
		queue_free()

func _set_state():
	var state = "Idle"
	
	if direction != 0:
		state = "Walking"
		
	animations.play(state)
