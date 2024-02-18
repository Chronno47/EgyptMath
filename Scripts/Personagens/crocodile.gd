extends Personagens_Gerais

@onready var animations := $"AnimatedSprite2D"
@onready var p_detector_left := $"Player_Detector_Left" as RayCast2D
@onready var p_detector_right := $"Player_Detector_Right" as RayCast2D
@onready var hitbox := $"Hitbox Component/CollisionShape2D"

var croc_speed = move_speed * 0.30
var direction:int

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if p_detector_left.is_colliding():
		_switch_directions(-1)
		velocity.x = croc_speed * direction
	if p_detector_right.is_colliding():
		_switch_directions(1)
		velocity.x = croc_speed * direction
	
	
	_set_state()
	move_and_slide()

func _switch_directions(new_direction:int):
	direction = new_direction
	animations.scale.x = -direction
	hitbox.position.x *= -1


func _set_state():
	var state = "Idle"
	
	if direction != 0:
		state = "Walking"
		
	animations.play(state)
