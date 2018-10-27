extends Node

onready var board = get_parent()

func _ready():
	randomize()
	pass # Replace with function body.

func _process(delta):
	
	if board.ganhador || board.estado_atual.vez == 1: return
		
	var e = board.estado_atual.clone()	
	e.joga(1)	
	var coluna = 1
	var max_h = e.calc_heuristica(-1)
	for i in range(2,7):
		e = board.estado_atual.clone()
		if(e.joga(i)):
			var h = e.calc_heuristica(-1)
			print("Coluna "+str(i)+": "+str(h))
			if(h>max_h or (h==max_h and randf()>0.5)):
				max_h = h
				coluna = i

	print("max_h: "+str(max_h)+" em "+str(coluna))

	if board.joga(coluna): 
		pass