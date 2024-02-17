extends MarginContainer

signal finished_displaying

@onready var text_label := $MarginContainer/Label
@onready var letter_timer := $"LetterDisplayTimer"

#Tamanho maximo da caixa de dialogo
const MAX_WIDTH = 256

var text = ""
var letter_index = 0
#tempo pra cada letra aparecer e tempo pro espaço e pontuação
var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

func display_text(text_to_display:String):
	text = text_to_display
	text_label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	#se o tamanho da caixa ultrapassar o limite, o texto pula pra proxima linha
	if size.x > MAX_WIDTH:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #aguarda resized do eixo X
		await resized #aguarda resized do eixo Y
		custom_minimum_size.y = size.y
	
	#posicionamento do caixa de dialogo
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
		
	text_label.text = ""
	_display_letter()

#função pra digitar letra por letra na caixa de dialogo
func _display_letter():
	text_label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			letter_timer.start(punctuation_time)
		" ":
			letter_timer.start(space_time)
		_:
			letter_timer.start(letter_time)

func _on_letter_display_timer_timeout() -> void:
	_display_letter()
