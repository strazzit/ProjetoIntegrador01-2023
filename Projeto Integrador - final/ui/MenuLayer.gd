extends CanvasLayer

signal start_game # é usada para declarar um sinal em um script da Godot.

# ---------------------------------------------------------------------------
# 5 variaveis atribuidos a 5 nós
onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var high_score_label = $GameOverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu = $GameOverMenu
# ---------------------------------------------------------------------------

var game_started = false  #variavel para identificar se o jogo esta em execucao

func _input(event): # a função _input que é um método de tratamento de entrada de eventos na Godot. 
	if event.is_action_pressed("flap") && !game_started: #verificando se a ação "flap" foi pressionada e se o jogo não foi iniciado
		emit_signal("start_game")  # Emite um sinal chamado "start_game" 
		# ---------------------------------------------------------------------------
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		#Inicia uma animação de interpolação (tween) na propriedade "modulate:a" do nó start_message. 
		#Essa interpolação altera o valor da propriedade de "a" de 1 para 0 ao longo de 0,5 segundos. 
		#Isso provavelmente resultará em uma transição suave da opacidade do nó.
		# ---------------------------------------------------------------------------
		tween.start() # Inicia o tween para que a interpolação seja executada.
		game_started = true

func init_game_over_menu(score, highscore): # funcao quando o jogo acaba para exibir um menu de game over com informações sobre o score atual e o highscore alcançado.
	score_label.text = "SCORE: " + str(score) #Define o texto do label score_label concatenando a string "SCORE: " com o valor convertido para string de score.
	high_score_label.text = "BEST: " + str(highscore) #escore com o valor alcancado
	game_over_menu.visible = true # tornando-o visível na tela.

func _on_RestartButton_pressed():
# aviso-ignorar:return_value_discarded
# ------------------------------------------------------------------------------------------------------
	var _recarga = get_tree().reload_current_scene() # é usada para recarregar a cena atualmente em execução na Godot 
	#Engine. Isso significa que a cena será reiniciada, voltando ao seu estado inicial.
# ------------------------------------------------------------------------------------------------------
	Global.vidas = 1
