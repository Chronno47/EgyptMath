extends Node2D

signal player_enters_door

@onready var interaction_area := $"Interactable Area" as InteractionArea
@onready var states := $"States" as AnimatedSprite2D
var door_code:int
var calculo_result:int

func _ready():
		interaction_area.interact = Callable(self, "_on_interact")
		
func _on_interact():
	if calculo_result == door_code:
		emit_signal("player_enters_door")

func setup_door(code:int):
	door_code = code

func _set_state():
	var state = "Closed"
	
	if calculo_result == door_code:
		state = "Opening"
	
	if states.name != state:
		states.play(state)

func _on_calculo_component_result_updated(value):
	calculo_result = value
	_set_state()
