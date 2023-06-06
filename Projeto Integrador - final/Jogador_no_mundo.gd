extends RigidBody2D

#Signal usado para declarar um sinal personalizado
#signal morreu
onready var personagemPosition := $Position2D as Position2D
var player_ship: RigidBody2D = null

func _ready():
	# Carrega e instancia o nó do jogador
	player_ship = load(Global.playerDir).instance()
	# Define a posição global do jogador com base na posição do nó Position2D
	player_ship.global_position = personagemPosition.global_position
	# Adiciona o jogador como filho do nó atual
	add_child(player_ship)
