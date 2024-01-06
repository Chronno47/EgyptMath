extends Node2D

@onready var calculo_component := $"Calculo Component" as Node2D

var holder_quantity:int = 0
var holders_array:Array = []

func _ready():
	_count_holders()

func _count_holders():
	for child in get_children():
		if child is Holder:
			holder_quantity += 1
			holders_array.append(child)
			child.update_holder_status()
	print("Quantidade de Holders:", holder_quantity)
	print("Quantidade de Holders no Array:", holders_array.size())

func get_holder_quantity():
	return holder_quantity
