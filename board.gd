extends Sprite

var peca = preload("res://peca.tscn")

var prox_peca

var vez = 1
var cor = {
	1: Color(0.2,0.2,0.9),
	-1: Color(0.9,0.2,0.2)
}

var board = [
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0],
	[0,0,0,0,0,0]
]


func _ready():
	nova_peca() 

func nova_peca():
	prox_peca = peca.instance()
	prox_peca.modulate = cor[vez]
	prox_peca.position.y = -74
	$Pecas.add_child(prox_peca)

	
func clicou(coluna):
	joga(coluna)

func checa_ganhador():
	
		
	pass
	
func joga(coluna):
	var p = prox_peca
	var pos = Vector2(coluna-1,5)
	while(pos.y>=0 and board[pos.x][pos.y] != 0):
		pos.y -= 1
	
	if(pos.y<0):
		return

	board[pos.x][pos.y] = vez
	p.position = Vector2(74*pos.x, -74)
	$Tween.interpolate_property(p, "position", p.position, Vector2(74*pos.x, 74*pos.y), 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	vez *= -1
	nova_peca()

func _input(event):
	if(event is InputEventMouseMotion):
		prox_peca.position.x = event.position.x-280