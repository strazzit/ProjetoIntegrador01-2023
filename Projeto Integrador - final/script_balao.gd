extends Area2D

var balao_vida = 1
var velocidade = 4

func _physics_process(_delta): 
	global_position.x -= velocidade
	
	var posx = global_position.x;  # posx vai receber o valor da posicao do x, variaveis delimitador da tela
#	var posy = global_position.y;
	
	if (posx<0):  # se posx for maior que 0, o objeto vai ser destruido, serio o enemigo
		queue_free() # destroi o objeto

func _on_balaoVida_body_entered(body):
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("colisao")
	Global.vidas += balao_vida
	$CollisionShape2D.disabled = true
	if (body.name=="Jogador"):  # se um corpo colidir chamado superman
		body.ganhar_vida() # corpo vai chamar a funcao sofrer_dano


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "colisao":
		queue_free()
