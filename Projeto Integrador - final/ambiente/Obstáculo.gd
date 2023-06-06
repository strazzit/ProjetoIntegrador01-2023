extends Node2D

#signal obstaculo_criado(obs) # Sinal quando o personagem passar pelo cano, assim ganhar ponto

signal score #A declaração signal score define um sinal chamado "score".

onready var ponto = $Ponto # cria uma variável chamada ponto e atribui a ela uma referência ao nó com a identificação "Ponto" no cenário.

const SPEED = 215 #velocidade constante do obstaculo

func _physics_process(delta): #fazendo o obstaculo se mover
	position.x += -SPEED * delta #velocidade(-) pq o personagem vai pra esquerda e * delta pra manter a msm velocidade
	#-----------------------------------------------------------------------------
	#verifica se o obstáculo saiu completamente da tela para a esquerda, considerando uma posição limite de -200 no eixo horizonta
	if global_position.x <= -200: #significa que o personagem saiu da tela pra esquerda e realmente avançou alguma distância
		queue_free() # é chamada para remover o obstáculo do jogo, liberando seus recursos e removendo-o da cena.
	#-----------------------------------------------------------------------------

func _on_Cano_body_entered(body): #é um signal handler que é acionado quando o corpo de um objeto colide com o obstáculo representado por um "Cano" na cena. 
	if body is Jogador: # verifica se o objeto que colidiu é uma instância da classe "Jogador" usando a verificação if body is Jogador.
		if body.has_method("morreu"): #o obstaculo checa se o que atravessou é o jogador e se tiver um método chamado morreu,
			body.morreu()             #vai chamar esse método
			call_deferred("_disable_shape")
			
func _disable_shape():
	$Cano/CollisionShape2D.disabled = true
	$Cano2/CollisionShape2D.disabled = true

func _on_AreaPontuacao_body_exited(body): #  é um signal handler que é acionado quando o corpo de um objeto sai da área de pontuação representada por uma "AreaPontuacao" na cena. 
	if body is Jogador: #verifica se o objeto que saiu da área é uma instância da classe "Jogador" usando a verificação if body is Jogador.
		ponto.play() # para iniciar a reprodução de uma animação ou efeito sonoro associado ao ganho de pontos.
		emit_signal("score") #Emite um sinal chamado "score" usando a função
