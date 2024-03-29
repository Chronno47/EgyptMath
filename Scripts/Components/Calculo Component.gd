extends Node2D

signal result_updated(value:int)

@onready var holders_in_scene = get_parent()
const operator = preload("res://Scripts/Components/interaction_manager.gd").OperatorType

#verifica se essas variaves sao mandadas atualizadas
var holders_quantity:int = 0
var calculo_array:Array = []
var current_result:int = 0

func _ready():
	pass

func get_holder_array_info():
	holders_quantity = holders_in_scene.get_holder_quantity()
	calculo_array = holders_in_scene.get_holders_array()
	print("calculo array in component: ", calculo_array.size())

# se der no value, lembra que ele troca os enum pra string, e o for so verifica se tem int
func calculate_values():
	var expression: String = ""
	
	for i in range(holders_quantity):
		var valor = calculo_array[i]

		if typeof(valor) == TYPE_INT:
			if valor >= 0 && valor <= 9:
				print("valor é int")
				expression += str(valor)
			
			elif valor > 9:
				match valor:
					operator.ADICAO:
						print("operador de adicao")
						expression += " + "
					operator.SUBTRACAO:
						print("operador de subtracao")
						expression += " - "
					operator.MULTIPLICACAO:
						print("operador de multiplicacao")
						expression +=  " * "
					operator.DIVISAO:
						print("operador de divisao")
						expression += " / "
		else:
			print("no value")
	print("expressao:", expression)
	print("calculo array size: ", calculo_array.size())
	
	current_result = evaluate_expression(expression)
	emit_signal("result_updated", current_result)
	print(current_result)
	
func _on_holders_na_cena_on_item_placed():
	calculate_values()

## BUG,SE TIVER POR EXEMPLO [1,NULL,1] ELE VAI DAR 11
func evaluate_expression(expression: String) -> int:
	var tokens := expression.split(" ")
	
# Primeira etapa: resolver multiplicação e divisão
	var i := tokens.size() - 2
	while i >= 0:
		var operator_symbol := tokens[i]
		var operand := int(tokens[i + 1])

		if operator_symbol == "*":
			var previous_operand := int(tokens[i - 1])
			tokens.remove_at(i)
			tokens.remove_at(i)
			tokens[i - 1] = str(previous_operand * operand)
			i -= 2
		elif operator_symbol == "/":
			var previous_operand := int(tokens[i - 1])
			if operand != 0:
				tokens.remove_at(i)
				tokens.remove_at(i)
				tokens[i - 1] = str(previous_operand / operand)
				i -= 2
			else:
				print("Erro: Divisão por zero!")
				return 0
		else:
			i -= 2

	# Segunda etapa: resolver adição e subtração
	var result: int = int(tokens[0])
	for j in range(1, tokens.size(), 2):
		var operator_symbol := tokens[j]
		var operand := int(tokens[j + 1])

		match operator_symbol:
			"+" :
				result += operand
			"-" :
				result -= operand

	return result
