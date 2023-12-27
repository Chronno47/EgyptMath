extends Area2D
class_name Hurtbox

#Referenciando variaveis com nós
@onready var hurtbox_collision := $HurtboxCollision as CollisionShape2D
@onready var invincibility_time := $InvincibilityTime as Timer

#region ajustes de frames de invincibilidade depois de tomar dano
func _on_body_entered(hitbox: Hitbox ) -> void:
	if owner.has_method("take_damage"):
		_invincibility_start()
		owner.take_damage(hitbox.damage)

func _on_invincibility_time_timeout():
	hurtbox_collision.disabled = false

func _invincibility_start() -> void:
	hurtbox_collision.set_deferred("disabled", true)
	invincibility_time.start()
	
#endregion
