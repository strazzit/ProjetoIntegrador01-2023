extends Node2D

# -------------------------------------------------------
# 4 variaveis atribuindo 4 nós
onready var hud = $HUD
onready var gerador_obstaculo = $GeradorObstaculo
onready var gerador_baloes = $GeradorBaloes
onready var chao = $Chao
onready var menu_layer = $MenuLayer
# -------------------------------------------------------

const SAVE_FILE_PATH = "user://savedata.save" # representa o caminho do arquivo de salvamento no diretório do usuário.

# ------------------------------------------------------------------------------------------------------
#Uma variável chamada score com um valor inicial de 0 e utiliza a declaração setget para personalizar 
#a leitura e escrita dessa variável.
#Ao usar setget set_score, você está definindo um setter personalizado para a variável score.
var score = 0 setget set_score
# ------------------------------------------------------------------------------------------------------
var highscore = 0

func _ready():
	# ------------------------------------------------------------------------------------------------------
	#Aqui, está sendo feita uma conexão entre o sinal "obstaculo_criado" do nó gerador_obstaculo e o método _on_obstaculo_criado
	# do próprio nó em que o código está sendo executado. 
	#Isso significa que sempre que o sinal "obstaculo_criado" for emitido pelo gerador_obstaculo, o método 
	gerador_obstaculo.connect("obstaculo_criado", self, "_on_obstaculo_criado")
	# ------------------------------------------------------------------------------------------------------
	load_highscore() # funcao de carrefar score mais alto
	Global.sinal = 0
	Global.novo_jogo = 0
	
func _physics_process(_delta): 
	if Global.sinal == 1:  # uma forma de substituir o sinal, na hora da morte
		Global.sinal = 0
	if Global.vidas < 1:
		game_over()
		

func new_game():
	self.score = 0 # atributo score do objeto atual está sendo definido como 0. Isso implica em reiniciar o valor do score para zero quando a função new_game() é chamada.
	gerador_obstaculo.start() # iniciar timer obstaculo
	gerador_baloes.start() # iniciar timer

func player_score():
	self.score += 1 #  adiciona 1 ao valor do atributo score do objeto atual. Isso implica em aumentar o valor do score em 1 toda vez que a função player_score() é chamada.

func set_score(new_score): #Recebe um novo valor de pontuação (new_score) 
	score = new_score # atribui esse valor ao atributo score.
	hud.update_score(score) #chama a função update_score() do objeto hud, passando o valor atualizado de score como argumento.

func _on_obstaculo_criado(obs): # é um receptor de sinal que é acionado quando um obstáculo é criado. Ela recebe o objeto obstáculo (obs) como argumento.
	obs.connect("score", self, "player_score") #Isso significa que quando o obstáculo emitir o sinal "score", a função player_score será chamada.

func _on_ZonaDeMorte_body_entered(body): #é um receptor de sinal que é acionado quando um corpo rígido entra na zona de morte. Ela recebe o corpo rígido (body) como argumento.
	if body is Jogador: #verificado se o corpo rígido é do tipo "Jogador" usando a condição body is Jogador
		if body.has_method("morreu"): #Se o corpo rígido for do tipo "Jogador", verifica-se se ele possui um método chamado "morreu" usando body.has_method("morreu").
			body.morreu() # Esse método provavelmente contém a lógica para tratar a morte do jogador, como encerrar o jogo, mostrar uma tela de game over, etc.

#func _on_Jogador_morreu(): # é um receptor de sinal que é acionado quando o sinal "morreu" é emitido pelo objeto "Jogador". 
#	game_over()
	
func game_over():
	gerador_obstaculo.stop() #Interrompe a geração de obstáculos no jogo
	gerador_baloes.stop() 
	Global.vidas = 0
	chao.get_node("AnimationPlayer").stop() #Para a reprodução de animação do objeto "chao"
	#--------------------------------------------------------------------------------------------
	# Chama a função "set_physics_process(false)" em todos os nós do grupo "obstaculos".
	get_tree().call_group("obstaculos", "set_physics_process", false)
	#Isso provavelmente desativa o processamento físico dos obstáculos, fazendo com que eles parem de se mover.
	#--------------------------------------------------------------------------------------------
	
	if score > highscore: # verifica se a pontuação atual é maior do que a pontuação mais alta (highscore) registrada anteriormente. 
		highscore = score
		save_highscore() # é chamada para salvar a nova pontuação mais alta.
	
	menu_layer.init_game_over_menu(score, highscore)# Chama a função, para exibir um menu de fim de jogo, passando a pontuação atual e a pontuação mais alta como parâmetros.

func _on_MenuLayer_start_game(): #A função _on_MenuLayer_start_game() é chamada quando o evento "start_game" é emitido pelo objeto MenuLayer
	new_game()
	
func save_highscore(): #é responsável por salvar o valor do highscore (pontuação máxima) em um arquivo.
	var save_data = File.new() #Cria uma instância do objeto File chamada save_data.
	save_data.open(SAVE_FILE_PATH, File.WRITE) #bre o arquivo especificado em SAVE_FILE_PATH no modo de escrita usando o método open() do objeto save_data.
	save_data.store_var(highscore) # Armazena o valor do highscore no arquivo usando o método store_var() do objeto save_data.
	save_data.close() #Fecha o arquivo usando o método close() do objeto save_data.
	
func load_highscore(): #é responsável por carregar o valor do highscore (pontuação máxima) de um arquivo.
	var save_data = File.new() #Cria uma instância do objeto File chamada save_data.
	if save_data.file_exists(SAVE_FILE_PATH): # Verifica se o arquivo especificado em SAVE_FILE_PATH existe usando o método file_exists() do objeto save_data.
		save_data.open(SAVE_FILE_PATH, File.READ) #Se o arquivo existir, abre o arquivo no modo de leitura usando o método open() do objeto save_data.
		highscore = save_data.get_var() #Obtém o valor do highscore do arquivo usando o método get_var() do objeto save_data e atribui esse valor à variável highscore.
		save_data.close() #Fecha o arquivo usando o método close() do objeto save_data.


func _on_TextureButton_pressed() -> void:
	var _Altera_para = get_tree().change_scene("res://ambiente/SelectScreen.tscn")  # vai nos levar ate nosso jogo
