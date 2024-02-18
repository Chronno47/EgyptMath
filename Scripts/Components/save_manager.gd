extends Node

static var saved_game_scene_path = ""
const SAVE_FILE_PATH = "user://egyptmath_savefile.cfg"

func save_game_scene(scene_path):
	saved_game_scene_path = scene_path
	var save_file = ConfigFile.new()
	save_file.set_value("Scene_Save", "saved_scene_path", saved_game_scene_path)
	save_file.save(SAVE_FILE_PATH)

# Método para carregar o caminho da cena salva do arquivo de save
func load_saved_scene_path() -> String:
	var save_file = ConfigFile.new()
	if save_file.load(SAVE_FILE_PATH) == OK:
		return save_file.get_value("Scene_Save", "saved_scene_path", "")
	else:
		return ""

func check_for_save():
	return saved_game_scene_path != ""
