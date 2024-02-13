extends Area2D
class_name Hurtbox
#Box que diz onde o personagem toma dano

#Referenciando variaveis com nós
@onready var hurtbox_collision := $HurtboxCollision as CollisionShape2D
@onready var invincibility_time := $InvincibilityTime as Timer

var on_invincibility:bool = false

## LEMBRA DE COLOCAR CONNECT DO TIMER NO READY E NAO NO INSPETOR
func _ready():
	self.connect("area_entered", _on_area_entered)
	invincibility_time.timeout.connect(_on_invincibility_timeout)

#region ajustes de frames de invincibilidade depois de tomar dano
func _on_area_entered(hitbox: Hitbox ) -> void:
	if owner.has_method("take_damage") && !on_invincibility:
		_invincibility_start()
		owner.take_damage(hitbox.damage)

func _on_invincibility_timeout():
	on_invincibility = false

func _invincibility_start() -> void:
	on_invincibility = true
	invincibility_time.start()
	
#endregion
