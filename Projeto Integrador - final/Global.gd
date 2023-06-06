extends Node

var playerDir
var player : Node2D

var vidas = 1

var sinal = 0
var novo_jogo = 0

func _ready():
	playerDir = "res://personagens/jogador/Jogador.tscn"#
	pass
	
func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance
