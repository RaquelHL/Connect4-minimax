extends Node

onready var board = get_parent()

func _ready():
	randomize()
	pass # Replace with function body.

func _process(delta):
	if board.ganhador: return
	
	var coluna = randi() % 7 + 1
	if board.joga(coluna):