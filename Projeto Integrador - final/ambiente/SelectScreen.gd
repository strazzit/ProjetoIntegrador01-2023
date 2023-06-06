extends Control

var amarelo = "res://personagens/jogador/Jogador.tscn"
var azul = "res://personagens/jogador/jogador2.tscn"
var angle = "res://personagens/jogador/jogador3.tscn"
var mario = "res://personagens/jogador/Jogador4.tscn"
var angleAmarelo = "res://personagens/jogador/Jogador5.tscn"
var vermelho = "res://personagens/jogador/Jogador6.tscn"
var preto = "res://personagens/jogador/Jogador7.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func goToScene():
	var _entrar_jogo = get_tree().change_scene("res://Mundo.tscn")

func _on_amareloButton_pressed() -> void:
	$AudioBotao.play()
	Global.playerDir = amarelo
	goToScene()

func _on_AzulButton_pressed() -> void:
	$AudioBotao.play()
	Global.playerDir = azul
	goToScene()

func _on_AngleButton_pressed() -> void:
	$AudioBotao.play()
	Global.playerDir = angle
	goToScene()

func _on_marioButton_pressed():
	$AudioBotao.play()
	Global.playerDir = mario
	goToScene()

func _on_angleAmareloButton_pressed():
	$AudioBotao.play()
	Global.playerDir = angleAmarelo
	goToScene()

func _on_VermelhoButton_pressed():
	$AudioBotao.play()
	Global.playerDir = vermelho
	goToScene()

func _on_pretoButton_pressed():
	$AudioBotao.play()
	Global.playerDir = preto
	goToScene()
