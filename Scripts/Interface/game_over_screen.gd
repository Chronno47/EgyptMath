extends Control

func _on_restart_button_pressed() -> void:
	SceneSwitcher.switch_scene(PlayerInfo.previous_scene_path)
func _on_quit__button_pressed() -> void:
	SceneSwitcher.switch_scene("res://Cenas/Interface/main_menu.tscn")
