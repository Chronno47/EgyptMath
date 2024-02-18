extends Control


func _on_novo_jogo_pressed() -> void:
	if !SaveManager.check_for_save():
		SceneSwitcher.switch_scene("res://Cenas/Salas/Salas do Jogo/adicao_level_1.tscn")
	else:
		pass #SUBSTITUI POR POPUP DE TEM CERTEZA QUE QUER INICIAR NOVO JOGO

func _on_continuar_pressed() -> void:
	var saved_scene_path = SaveManager.load_saved_scene_path()
	if saved_scene_path:
		SceneSwitcher.switch_scene(saved_scene_path)

func _on_historia_pressed() -> void:
	SceneSwitcher.switch_scene("res://Cenas/Interface/story_menu.tscn")

func _on_opcoes_pressed() -> void:
	pass # Replace with function body.

func _on_sair_pressed() -> void:
	get_tree().quit()
