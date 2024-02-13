extends Node2D

const orb_projectile = preload("res://Cenas/Inimigos/orb_projectile.tscn")

@onready var animations := $"Animacoes" as AnimatedSprite2D
@onready var atk_cd := $"AttackCooldown" as Timer
@onready var orb_spawn := $"Orb_Spawnpoint" as Marker2D
@onready var detector_left := $"Player_Detector_Left" as RayCast2D
@onready var detector_right :=  $"Player_Detector_Right" as RayCast2D

#verifica se esta em cooldown ou nao
var on_cd:bool = false

func _physics_process(_delta: float):
	if detector_left.is_colliding() && !on_cd:
		spawn_orb(-1)
	if detector_right.is_colliding() && !on_cd:
		spawn_orb(1)
	
	_set_state()
	
func spawn_orb(direction):
	var new_orb = orb_projectile.instantiate()
	add_sibling(new_orb)
	new_orb.global_position = orb_spawn.global_position
	new_orb.set_direction(direction)
	on_cd = true
	atk_cd.start()

func _on_attack_cooldown_timeout() -> void:
	on_cd = false

## CONSERTAR O LOOP DO RECHARGE
func _set_state():
	var state = "Idle"
	
	if on_cd:
		state = "Recharge"
		animations.play(state)
		
	animations.play(state)
