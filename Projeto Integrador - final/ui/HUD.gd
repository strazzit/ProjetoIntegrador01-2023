extends CanvasLayer

onready var score_label = $Score  # criando uma variavel para atribuir a ela a referencia ao label "Score"

func update_score(new_score):  # atualizando o novo recoerde de pontos
	score_label.text = str(new_score) #stá atribuindo o valor convertido para string da variável new_score à propriedade text do objeto score_label.
