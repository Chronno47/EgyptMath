extends Personagens_Gerais

@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var wall_detector_left := $"Wall_Detector_Left" as RayCast2D
@onready var wall_detector_right := $"Wall_Detector_Right" as RayCast2D
@onready var hitbox := $"Hitbox Component/Hitbox"
@onready var hurtbox := $"Hurtbox Component/Hurtbox"
@onready var ground_detector_left := $"Ground_Detector_Left" as RayCast2D
@onready var ground_detector_right := $"Ground_Detector_Right" as RayCast2D
@onready var ceiling_detector_left := $"Ceiling_Detector_Left" as RayCast2D
@onready var ceiling_detector_right := $"Ceiling_Detector_Right" as RayCast2D

var health:int = 3

var char_on_ground:bool = false
var char_on_ceiling:bool = false

var is_gravity_on:bool = true
var direction := -1

func _physics_process(delta: float) -> void:
	if is_gravity_on:
		velocity.y += gravity * delta
	
	if char_on_ground && !wall_detector_left.is_colliding() || !wall_detector_right.is_colliding():
		_walk()
	
	if wall_detector_left.is_colliding() || wall_detector_right.is_colliding():
		_go_up()
	
	if char_on_ceiling:
		if wall_detector_left.is_colliding() || wall_detector_right.is_colliding():
			_switch_direction()
			_walk()
	
	_set_state()
	_onground_check()
	_onceiling_check()
	move_and_slide()

func _onground_check():
	if ground_detector_left.is_colliding() && ground_detector_right.is_colliding():
		char_on_ground = true
	else:
		char_on_ground = false
	

func _onceiling_check():
	if ceiling_detector_left.is_colliding() && ceiling_detector_right.is_colliding():
		char_on_ceiling = true
		is_gravity_on = false
	else:
		char_on_ceiling = false
		is_gravity_on = true

func _walk():
	velocity.x = direction * (move_speed * 0.60)
	animations.scale.x = direction

func _switch_direction():
	direction *= -1
	hitbox.position.x *= -1
	hurtbox.position.x *= -1

func _go_up():
	if !char_on_ceiling:
		velocity.y = direction * (move_speed * 0.60)
		animations.scale.y = -direction

func take_damage(damage:int):
	health -= damage
	if health <= 0:
		queue_free()

func _set_state():
	var state = "Idle"
	
	if direction != 0:
		state = "Walking"
		
	animations.play(state)
