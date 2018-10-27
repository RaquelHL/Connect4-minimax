extends Sprite

export(NodePath) var IA

var Estado = preload("res://estado.gd")


var peca = preload("res://peca.tscn")

var prox_peca
 
var ganhador = 0
var cor = {
	1: Color(0.2,0.2,0.9),
	-1: Color(0.9,0.2,0.2)
}

var estado_atual = Estado.new()

func _ready():
	IA = get_node(IA)
	nova_peca() 

func nova_peca():
	prox_peca = peca.instance()
	prox_peca.modulate = cor[estado_atual.vez]
	prox_peca.position.y = -74
	$Pecas.add_child(prox_peca)

func clicou(coluna):
	#if not estado_atual.vez == 1:
#		return
	joga(coluna)

	
func _process(dt):
	if(ganhador==0):
		pass#IA.joga()

func joga(coluna):
	if ganhador !=0:
		return
	var p = prox_peca
	
	var result = estado_atual.joga(coluna)
	if !result:
		return false
	var pos = result
	p.position = Vector2(74*pos.x, -74)
	$Tween.interpolate_property(p, "position", p.position, Vector2(74*pos.x, 74*pos.y), 1, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$Tween.start()
	if(abs(estado_atual.calc_heuristica(1))>10000):
		jogador_ganhou()
	
	print("h = "+str(estado_atual.calc_heuristica(1)))
	nova_peca()
	
	if estado_atual.vez == -1:
		IA.joga()
	return true

func jogador_ganhou():
	print(estado_atual.vez*-1, ' ganhou')
	ganhador = estado_atual.vez*-1
	pass

		
		
			
	

func _input(event):
	if(event is InputEventMouseMotion):
		prox_peca.position.x = event.position.x-280