extends Node2D

var holder_quantity_array: Array = []
@onready var holder_scene = preload("res://Scripts/Components/holders_na_cena.gd").new()

func initialize_scene_puzzle():
	var holder_count = holder_scene.get_holder_quantity()
	holder_quantity_array.resize(holder_count)
	print("Quantidade de Holders no Componente de Cálculo:", holder_quantity_array.size())
