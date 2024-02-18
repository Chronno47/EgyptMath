extends Node2D

signal player_enters_door

@onready var interaction_area := $"Interactable Area" as InteractionArea
@onready var states := $"States" as AnimatedSprite2D
var door_code:int
var calculo_result:int
var artifact_collected:bool = false

func _ready():
		interaction_area.interact = Callable(self, "_on_interact")
		
func _on_interact():
	if calculo_result == door_code || artifact_collected:
		player_enters_door.emit()

func setup_door(code:int):
	door_code = code

func _set_state():
	var state = "Closed"
	
	if calculo_result == door_code || artifact_collected:
		state = "Opening"
	
	if states.name != state:
		states.play(state)

func _on_calculo_component_result_updated(value):
	calculo_result = value
	_set_state()

func _on_artifact_collected() -> void:
	artifact_collected = true
	_set_state()
