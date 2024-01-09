extends Node2D

const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

#verifica se essas variaves sao mandadas atualizadas
var holders_quantity:int
var holders_array:Array 

func _ready():
	pass

func get_holder_array_info(quantity:int, holder_array:Array):
	holders_quantity = quantity
	holders_array = holder_array
	print("holders array in component: ", holders_array.size())

func check_value_type():
	var value1:int
	var value2:int
	var value3:int
	var value4:int
	var value5:int
	
	for i in range(holders_quantity):
		var valor = holders_array[i]
		if typeof(valor) == TYPE_INT:
			if valor >= 0 && valor <= 9:
				print("valor é int")
			
			elif valor > 9:
				match valor:
					operator.ADICAO:
						print("operador de adicao")
					operator.SUBTRACAO:
						print("operador de subtracao")
					operator.MULTIPLICACAO:
						print("operador de multiplicacao")
					operator.DIVISAO:
						print("operador de divisao")
		else:
			print("no value")
	print("current array size: ", holders_array.size())

func _on_holders_na_cena_on_item_placed():
	check_value_type()
