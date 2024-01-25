extends VBoxContainer

const Heart_Texture = preload("res://Cenas/Interface/health_heart.tscn")

@onready var health_container := $"HealthContainer" as HBoxContainer

#Conectando sinal para quando a vida precisar ser mudada no codigo
func _ready():
	UiOnScreen.connect("health_changed", _on_health_changed)

#administra o que acontece quando toma dano/recupera vida
func _on_health_changed(old_hp:int, new_hp:int, max_hp:int):
	var current_hp = health_container.get_child_count()
	
	#o hp depois dele tomar dano vai ser usado pra remover um coração do healthcontainer
	if old_hp > new_hp:
		while new_hp < current_hp && current_hp > 0:
			health_container.remove_child(health_container.get_child(current_hp - 1))
			current_hp -= 1
	#e no else é pra caso ele recupere vida, instanciar uma nova cena de coração no healthcontainer
	else:
		while current_hp < new_hp &&  current_hp <= max_hp:
			var heart = Heart_Texture.instantiate()
			health_container.add_child(heart)
			current_hp += 1
