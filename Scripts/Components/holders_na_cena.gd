extends Node2D

@onready var calculo_component := $"Calculo Component" as Node2D

const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

var holder_quantity: int = 0
var holders_array: Array = []

func _ready():
	_count_holders()

func _count_holders():
	for child in get_children():
		if child is Holder:
			holder_quantity += 1
			holders_array.append(child)
			
	print("Quantidade de Holders:", holder_quantity)
	print("Quantidade de Holders no Array:", holders_array.size())

func get_holder_quantity():
	return holder_quantity


func _on_holder_1_on_coin_placed(holder_coin_value:int):
	if holder_quantity > 0:
		holders_array.insert(0, holder_coin_value)
		print("holder array 0: ", holders_array[0])

func _on_holder_1_on_operator_placed(operator_in_holder:operator):
	if holder_quantity > 0:
		holders_array.insert(0, operator_in_holder)
		print("holder array 0: ", holders_array[0])
