extends Node

signal score_changed

var score = 0 setget update_score
var gameover = false

func _ready():
	update_score(score)


func score_a_point():
	if not gameover:
		self.score += 1
		if gamemode.current_gamemode.highscore < score:
			gamemode.current_gamemode.set_highscore(score)
		update_score(score)


func update_score(new_score):
	score = new_score
#	print(score)
	emit_signal('score_changed')


func reset():
	self.score = 0
#	print('set score to 0')
