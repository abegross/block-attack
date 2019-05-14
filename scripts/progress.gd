extends Node

var progress

func _ready():
	progress = 1
	var file = File.new()
	if not file.file_exists('user://progress'):
		save()
	else:
		file.open('user://progress', File.READ)
		progress = file.get_8()
		file.close()

func update_progress():
	if gamemode.BUMPERS.highscore >= 100:
		progress = 2
	if gamemode.REGULAR.highscore >= 100:
		progress = 3
	if gamemode.INTANGIBLE.highscore >= 100:
		progress = 4

	save()

func save():
	var file = File.new()
	file.open('user://progress', File.WRITE)
	file.store_8(progress)
	file.close()