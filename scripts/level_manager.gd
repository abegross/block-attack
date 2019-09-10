extends Node

var menu_main			= preload('res://stages/menu_main.tscn')
var menu_level_select	= preload('res://stages/menu_level_select.tscn')
var game				= preload('res://stages/game.tscn')
var menu_gameover		= preload('res://stages/menu_gameover.tscn')

#enum stages {
#	menu_main,
#	menu_level_select,
#	game,
#	menu_gameover
#}

var stages = [menu_main, menu_level_select, game, menu_gameover]


func goto_level(stage):
	"""
	changes scene to a scene/stage/level
	args:
		stage: a scene file to go to (use one of the enum ontop of this file)
	"""
#	for stage in scenes:
	if stage is PackedScene:
		print("Loading scene " + stage.get_state().get_node_name(0))
		get_tree().change_scene_to(stage)


func goto_current_gamemode_level():
	gamemode.current_gamemode.goto_level()
	pass


func quit_game():
	get_tree().quit()
