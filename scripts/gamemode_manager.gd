extends Node
"""
Where all the inner workings any gamemode is.
It's set up in a way that to add or remove or change any gamemode,
you can just do it in one line in gamemode_manager!
"""

var highscores : Array = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]
var highscore = 0
#var highscores = {0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0}
var gamemode_name
var level_name
var unlocked = false
var filepath
var file = File.new()

func _init(gamemode_name):
	"""
	constructor

	args:
		gamemode_name: The name of this gamemode in all caps.
	"""
	filepath = 'user://'+gamemode_name
	self.gamemode_name = gamemode_name
	self.level_name = gamemode_name
	highscores = get_highscores()
	highscore = highscores[0][0]
#	print(highscores)
#	print(highscores[0][1])


func get_highscores() -> Array:
	"""
	Get all of this gamemode's highscores
	returns:

	"""
	file.open(filepath, File.READ)
	var hscore = str2var(file.get_as_text())
	file.close()
	if typeof(hscore) == TYPE_ARRAY:
#		for date in hscore:
#			date[1] = ('"'+str(date[1])+'"')
		return hscore
	else:
		return highscores


func save_highscore():
	"""
	Give this gamemode a new highscore
	Only use this function on gameover
	args:
		newHighscore: The new highscore to be given
	"""
	print('saving')
	for i in len(highscores):
		if score_controller.score > highscores[i][0]:
			highscores.insert(i, [score_controller.score,0])
			var d = OS.get_datetime()
#			dates.insert(i, (str(d.year)+'-'+"%02d"%d.month+'-'+"%02d"%d.day+' '+"%02d"%d.hour+':'+"%02d"%d.minute+':'+"%02d"%d.second))
			highscores[i][1] = (str(d.year)+'-'+"%02d"%d.month+'-'+"%02d"%d.day)#+' '+"%02d"%d.hour+':'+"%02d"%d.minute+':'+"%02d"%d.second)
			break
	while len(highscores) > 10:
		highscores.pop_back()
#	print('writing')
	file.open(filepath, File.WRITE)
#	file.store_string(str(highscores)+"\n"+str(dates))
	file.store_string(var2str(highscores))
	file.close()
#	print('done')


func set_highscore(new_highscore):
	"""
	Give this gamemode a new highscore
	args:
		newHighscore: The new highscore to be given
	"""
	highscore = new_highscore


func is_current_gamemode():
	"""
	Tests whether I'm the current gamemode
	returns:
		True if this item object is the current gamemode
	"""
	return self.name() == gamemode.current_gamemode.name()


func set_as_current_gamemode():
	"""
	Set this gamemode as the current gamemode
	"""
	gamemode.current_gamemode = self


func goto_level():
	"""
	Go to this gamemode's level.
	"""
	set_as_current_gamemode()
	level_manager.goto_level(level_manager.game)


func name():
	"""
	Gives the gamemode's name
	returns:
		The name of the gamemode
	"""
	return gamemode_name
