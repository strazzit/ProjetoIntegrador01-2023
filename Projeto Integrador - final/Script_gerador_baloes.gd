extends Node2D

onready var timer = $Timer # criando uma variavel para atribuir a ela a referencia ao nó "Timer"

var baloes = preload("res://ambiente/cena_balao_vida.tscn")  # carregando a cena obstaculo

func _ready():
	randomize()   # pedindo para ser aleatorio

func _on_Timer_timeout():  #  a cada 1.5 segundos spawnar outro obstaculo
	spawn_baloes()  

func spawn_baloes():
	var baloes_cena = baloes.instance()  # instanciando a cena
	add_child(baloes_cena)  # colocando na tela
	baloes_cena.position.y = randi()%400 + 150 #pegando um número qualquer entre 150-550

func start(): # iniciar timer 
	timer.start() 
	
func stop(): # stop timer 
	timer.stop()
