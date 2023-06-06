extends RigidBody2D
class_name Jogador #É útil para referenciar o nó por seu nome de classe em outros scripts ou na estrutura do projeto.

#signal morreu_enviar # é usada para declarar um sinal em um script da Godot.

#-------------------------------------------------------------------------------------------------------------------------------
# export antes da declaração da variável, ela se torna uma propriedade exportada. Isso significa que essa propriedade pode ser 
# modificada e visualizada no editor da Godot, permitindo ajustar seu valor sem precisar editar o código diretamente.
export var FLAP_FORCE = -340 #tem que ser negativo pois está indo pra cima
#-------------------------------------------------------------------------------------------------------------------------------

const MAX_ROTATION_DEGREES = -30.0 #setando limite pra quanto o jogador consiga girar no sentido anti-horário

# -----------------------------------------
# 3 variaveis atribuidos a 3 nós
onready var animator = $AnimationPlayer
onready var hit = $Hit
onready var asa = $Asa
#------------------------------------------

var started = false # vai ser usado pra checar se o jogo começou ou não
var alive = true  # variavel para saber se esta vivo ou morto o personagem

func _physics_process(_delta): 
	
	if Global.vidas >=1:
		if Input.is_action_just_pressed("flap") && alive : # verifica se foi precionado o botao de pular e se o personagem esta vivo
			if !started: # se o started for falso vai:
				start() # iniciar o jogo
			flap() # executar
	
		
	if rotation_degrees <= MAX_ROTATION_DEGREES: # se rotacao da Sprite do "Inspetor", "Transform" for menor ou igual a MAX_ROTATION_DEGREES
		angular_velocity = 0 # setando pra nao girar mais
		rotation_degrees = MAX_ROTATION_DEGREES 
		
	if linear_velocity.y > 0: # maior do que 0 indica que o bird está "caindo"
		if rotation_degrees <= 90: # menor ou igual a 90 indica que o bird não atingiu o limite, portanto vai continuar "rodando"
			angular_velocity = 5  # velocidade angular, tempo q o bird "vira" pra baixo e começa a cair
		else:
			angular_velocity = 0 # quando o bird começar a cair, o valor 0 indica que ele não continuará "rodando" 
		
func start(): # iniciar o jogo
	if started: return  # verifica se a variável started é verdadeira.
	# Se a condição for verdadeira, a função é interrompida e a execução retorna ao ponto de chamada imediatamente.
	# SE for falsa, vai execuatar estes codigos:
	started = true
	gravity_scale = 10.0
	animator.play("flap") # dar play na animacao do personagem voando
	
func flap(): # funcao o passaro voar para cima
	linear_velocity.y = FLAP_FORCE # Isso faz com que o jogador seja impulsionado para cima quando ocorre um comando de "flap"(bater de asas).
	angular_velocity = -8.0
	asa.play() # audio do bater das assas

func morreu(): 
	if !alive: return # verifica se a variável alive é falsa.
	if Global.vidas < 1:
		alive = false
		animator.stop() #parar de "pular" quando o bird morre, animacao parar
	hit.play() # audio quando morre 
	Global.sinal = 1
	Global.vidas -= 1
	
func ganhar_vida():
	$AnimationPlayer.play("especial")  # vai dar play na animacao

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "especial":
		animator.play("flap")  # vai dar play na animacao sofrendo_dano
