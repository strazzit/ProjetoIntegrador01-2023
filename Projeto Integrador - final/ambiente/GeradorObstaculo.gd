extends Node2D

signal obstaculo_criado(obs) # Sinal quando o personagem passar pelo cano, assim ganhar ponto

onready var timer = $Timer # criando uma variavel para atribuir a ela a referencia ao nó "Timer"

var Obstaculo = preload("res://ambiente/Obstáculo.tscn")  # carregando a cena obstaculo

func _ready():
	randomize()   # pedindo para ser aleatorio

func _on_Timer_timeout():  #  a cada 1.5 segundos spawnar outro obstaculo
	spawn_obstaculo()  

func spawn_obstaculo():
	var obstaculo = Obstaculo.instance()  # instanciando a cena
	add_child(obstaculo)  # colocando na tela
	obstaculo.position.y = randi()%400 + 150 #pegando um número qualquer entre 150-550
	emit_signal("obstaculo_criado", obstaculo)  # emitindo um sinal personalizado para o obstaculo
	
func start(): # iniciar timer obstaculo
	timer.start() 
	
func stop(): # stop timer obstaculo
	timer.stop()
