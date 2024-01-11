extends Node2D

@onready var stage_end_door := $"StageEnd_Door" as Node2D

func _ready():
	stage_end_door.setup_door(3)
