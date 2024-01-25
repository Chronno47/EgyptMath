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

# se der no value, lembra que ele troca os enum pra string, e o for so verifica se tem int
func calculate_values():
	var expression: String = ""
	var array_is_full:bool = true
	
	#verifica se o array ta com todas as posições cheias antes de fazer o calculo
	for i in range(holders_quantity):
		var valor = calculo_array[i]
		if valor == null:
			array_is_full = false
	
	if array_is_full:
		for i in range(holders_quantity):
			var valor = calculo_array[i]
			if typeof(valor) == TYPE_INT:
				if valor >= 0 && valor <= 9:
					print("valor é int")
					expression += str(valor)
			
				elif valor > 9:
					match valor:
						operator.ADICAO:
							expression += " + "
						operator.SUBTRACAO:
							expression += " - "
						operator.MULTIPLICACAO:
							expression +=  " * "
						operator.DIVISAO:
							expression += " / "

		current_result = evaluate_expression(expression)
		emit_signal("result_updated", current_result)
		print(current_result)
	
func _on_holders_na_cena_on_item_placed():
	calculate_values()

## BUG,SE TIVER POR EXEMPLO [1,NULL,1] ELE VAI DAR 11
func evaluate_expression(expression: String) -> int:
	
	var operators:Array[String] = []
	var operands:Array[int] = []
	
	var tokens := expression.split(" ")
	
	for token in tokens:
		match token:
			"+":
				operators.append(token)
			"-":
				operators.append(token)
			"*":
				operators.append(token)
			"/":
				operators.append(token)
			_:
				operands.append(int(token))
				
	var i = 0
	while i < operators.size():
		if operators[i] == "*" || operators[i] == "/":
			var op = operators[i]
			var left = operands[i]
			var right = operands[i+1]
			operators.remove_at(i)
			if op == "*":
				operands[i] = left * right
			elif right != 0:
				operands[i] = left / right
			else:
				print("Erro: Divisão por zero!")
				return 0
		else:
			i += 1
	
	i = 0
	while i < operators.size():
		var op = operators[i]
		var left = operands[i]
		var right = operands[i+1]
		operators.remove_at(i)
		if op == "+":
			operands[i] = left + right
		else:
			operands[i] = left - right
	return operands[0]
