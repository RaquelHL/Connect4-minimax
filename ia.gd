extends Node

onready var jogo = get_parent()

var max_prof = 3

func _ready():
	randomize()

func jogaBurro():	
	var e = jogo.estado_atual.clone()	
	e.joga(1)	
	var coluna = 1
	var max_h = e.calc_heuristica(-1)
	for i in range(2,7):
		e = jogo.estado_atual.clone()
		if(e.joga(i)):
			var h = e.calc_heuristica(-1)
			print("Coluna "+str(i)+": "+str(h))
			if(h>max_h or (h==max_h and randf()>0.5)):
				max_h = h
				coluna = i

	print("max_h: "+str(max_h)+" em "+str(coluna))

#Minimax
func joga():
	#Constrói arvore
	var arvore = faz_jogadas(jogo.estado_atual, 0)
	var jogada = minimax(arvore, 0)
	print("jogando em "+str(jogada[0])+": "+str(jogada[1]))
	jogo.joga(jogada[0])

	pass

func minimax(jogadas, prof):

	var tabs = ""
	for i in range(0,prof):
		tabs+='\t'
	var opcoes = "["
	var melhor_h
	var melhor_coluna
	if(prof%2==0):
		melhor_h = -99999
	else:
		melhor_h = 99999

	for i in range(1,8):
		var h
		if(!jogadas.has(i)):
			continue
		if(jogadas[i].folha):
			h = jogadas[i].pontuacao
		else:
			#print(tabs+"prof "+str(prof)+" na coluna "+str(i))
			h = minimax(jogadas[i].filhos, prof+1)[1]

		opcoes += str(h)+", "
		if(prof%2==0):	#Max
			if(h>melhor_h):
				melhor_h = h
				melhor_coluna = i
		else:			#Min
			if(h<melhor_h):
				melhor_h = h
				melhor_coluna = i
	opcoes += "]"
	#print(tabs+"prof "+str(prof)+" escolhendo "+str(melhor_coluna)+" com "+str(melhor_h)+" "+opcoes)
	return [melhor_coluna, melhor_h]
	pass

func faz_jogadas(board, prof):
	var jogadas = {}
	var e
	for i in range(0,8):
		e = board.clone()
		if(e.joga(i)):
			if(prof<max_prof):
				e.filhos = faz_jogadas(e, prof+1)
			else:
				e.pontuacao = e.calc_heuristica(-1)
				#print(str(prof)+": "+str(e.pontuacao))
				e.folha = true
			jogadas[i] = e
	
	return jogadas
			