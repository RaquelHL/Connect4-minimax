
const D_DIR = Vector2(1,0)	#Direita 
const D_ESQ = Vector2(-1,0)	#Esquerda
const D_VER = Vector2(0,-1)	#Vertical
const D_DIE = Vector2(-1,-1)	#Diagonal esquerda
const D_DID = Vector2(1,-1)	#Diagonal direita

var board = [
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0]
]
var vez = 1
var pontuacao = 0

func _init():
	pass
	#print(lv.a)

func clone():
	var cl = get_script().new()
	for i in range(0,7):
		for j in range(0,6):
			cl.board[i][j] = board[i][j]
	cl.vez = vez
	return cl

func joga(coluna):
	var pos = Vector2(coluna-1,5)
	while(pos.y>=0 and board[pos.x][pos.y] != 0):
		pos.y -= 1
	
	if(pos.y<0):
		return false
	
	board[pos.x][pos.y] = vez
	return pos
	#pontuacao = calc_heuristica(vez)
	
		

func check_pos(pos, dir):
	var jogador = board[pos.x][pos.y]
	var seq = 1
	pos += dir
	if(pos.x>5 || pos.y > 6):
		return 0
	while(board[pos.x][pos.y] == jogador):
		pos += dir
		if(pos.x>5 || pos.y > 6):
			return 0
		seq += 1
	
	if(board[pos.x][pos.y] == 0):	#Sequencia valida
		if seq>1:
			return pow(seq,2)
		else:
			return 0
	else:	#Sequencia bloqueada
		#print("sequencia de "+str(seq)+" bloqueada")
		return 0

func calc_heuristica(jogador):
	var h = 0
	for i in range(0,7):
		for j in range(4,6):
			if(board[i][j]==jogador):
				h+= check_pos(Vector2(i,j), D_DIR)
				h+= check_pos(Vector2(i,j), D_VER)
				h+= check_pos(Vector2(i,j), D_DIE)
				h+= check_pos(Vector2(i,j), D_DID)
		for j in range(5,0,-1):
			if(board[i][j]==jogador):
				h+= check_pos(Vector2(i,j), D_ESQ)
	return h

func checa_ganhador(pos):

	var iguais
	var dir
	var check_pos
	
	# | só precisa verificar pra baixo, uma vez que a última peça lançada sempre estará no topo
	iguais = 1
	dir = Vector2(0, 1)
	check_pos = pos + dir
	while(1):
		if check_pos.y > 5:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos += dir
	
	if iguais >= 4:
		
		return true
	
	# /
	iguais = 1
	dir = Vector2(-1,1)
	check_pos = pos + dir
	while(1):
		if check_pos.y > 5 or check_pos.x < 0:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos += dir
	
	check_pos = pos - dir
	while(1):
		if check_pos.y < 0 or check_pos.x > 6:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos -= dir
	
	if iguais >= 4:
		return true
	
	# -
	iguais = 1
	dir = Vector2(1,0)
	check_pos = pos + dir
	while(1):
		if check_pos.x > 6:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos += dir
	
	check_pos = pos - dir
	while(1):
		if check_pos.x < 0:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos -= dir
	
	if iguais >= 4:
		return true
	
	# \
	iguais = 1
	dir = Vector2(1,1)
	check_pos = pos + dir
	while(1):
		if check_pos.y > 5 or check_pos.x > 6:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos += dir
	
	check_pos = pos - dir
	while(1):
		if check_pos.y < 0 or check_pos.x < 0:
			break
		if board[check_pos.x][check_pos.y] != vez or iguais >= 4:
			break
		
		iguais += 1
		check_pos -= dir
	
	if iguais >= 4:
		return true 
	pass
