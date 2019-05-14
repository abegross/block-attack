tool
extends Container


func _ready():
	var themet = preload("res://theme.tres")
#	color.randomizer([background, [$panel,themet, $panel/margin/ctnr_hs/desc], get_tree().get_nodes_in_group('level'), theme, get_tree().get_nodes_in_group('score')])


	for level in get_tree().get_nodes_in_group('level'):
		level.connect('on_pressed', self, '_level_pressed')
		var text = str(gamemode.get_gamemode(level.text).highscore)
		level.get_node('../grey').text = set_spaces(text)
		level.rect_min_size.x = 600
#		level.text = ' '+level.text+' '

	setup_progress()


#func _process(delta):
#	print(theme.get_stylebox_types())
#	print(theme.get_stylebox_list('Panel'))
#	var stylebox = StyleBoxFlat.new()
#	stylebox.bg_color = color.color
#	theme.set_stylebox('panel','Panel',stylebox)
func _level_pressed(text):
#	print(gamemode.current_gamemode.name())
	gamemode.set_gamemode(text)
#	print(gamemode.current_gamemode.name())
	if gamemode.current_gamemode.highscore == 0:
		get_tree().change_scene_to(preload("res://scenes/tutorials.tscn"))
	else:
		level_manager.goto_current_gamemode_level()

func setup_progress():
	"""
	setup all the levels to show up according to how many levels are unlocked
	"""
	for i in progress.progress:
		$ctnr_level.get_children()[i].get_node('grey').icon = null
		for btn in $ctnr_level.get_children()[i].get_children():
			btn.disabled = false
		$ctnr_level.get_children()[i].show()
		$ctnr_level.get_children()[i].get_node('grey').rect_min_size.x = 250
	if progress.progress < 4:
		$ctnr_level.get_children()[progress.progress].show()
		$ctnr_level.get_children()[progress.progress].get_node('grey').icon = preload('res://sprites/lock.png')
		$ctnr_level.get_children()[progress.progress].get_node('grey').rect_min_size.x = 250
		$ctnr_level.get_children()[progress.progress].get_node('grey').text = ''
		for btn in $ctnr_level.get_children()[progress.progress].get_children():
			btn.disabled = true
#			btn.material = null


func set_spaces(text):
#	var spaces = 5
#	var new_text = ""
#	for i in str(text).length():
#		spaces -= 1
#	for zero in range(spaces):
#		new_text += "|"
#	return new_text + text + " "
#	return "%5s" % text
	return text + ' '
