extends CanvasLayer

onready var score = $ctnr_hbox/score
onready var highscore = $ctnr_hbox2/highscore

func _ready():
#	score.modulate = color.color.inverted()
#	highscore.modulate = color.color.inverted()
	score_controller.connect("score_changed", self, 'update_score')
	update_score()

func update_score():
	score.text = "Score: " + str(score_controller.score)
	highscore.text = str(gamemode.current_gamemode.highscore)