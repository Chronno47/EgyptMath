extends Personagens_Gerais

# Atributos das animações, hitbox e hurtbox
@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var hitbox := $"Hitbox Component/Hitbox"
@onready var hurtbox := $"Hurtbox Component/Hurtbox"

# Vida do personagem
var health:int = 3

# Variável para controlar a gravidade
var is_gravity_on:bool = true

# Direção do movimento (1 para direita, -1 para esquerda)
var direction := 1

# Vetor de movimento
var move = Vector2(0,0)

# Variável para controle da rotação
var rotating:int 

# Função chamada a cada quadro para física do personagem
func _physics_process(delta: float) -> void:
	# Se estiver rotacionando, atualiza a rotação gradualmente
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return
	
	# Movimento horizontal e verificação de colisão
	var col := move_and_collide(move * 60 * delta)
	if col and col.get_normal().rotated(PI/2).dot(move) < 0.5:
		# Se houver colisão, rotaciona o personagem
		rotating = 4
		move = col.get_normal().rotated(PI/2)
		return
	
	# Movimento de rotação para contornar obstáculos
	var pos := position
	col = move_and_collide(move.rotated(PI/2) * 15)
	if not col:
		for i in 10:
			position = pos
			rotate(PI/32)
			move = move.rotated(PI/32)
			col = move_and_collide(move.rotated(PI/2) * 15)
			
			if col:
				move = col.get_normal().rotated(PI/2)
				rotation = move.angle()
				break
	else:
		move = col.get_normal().rotated(PI/2)
		rotation = move.angle()
	
	_set_state()

# Função para receber dano
func take_damage(damage:int):
	health -= damage
	if health <= 0:
		queue_free()

# Define o estado do personagem com base na direção do movimento
func _set_state():
	var state = "Idle"
	
	if direction != 0:
		state = "Walking"
		
	animations.play(state)

