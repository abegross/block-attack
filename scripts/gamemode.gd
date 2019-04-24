extends Node

onready var gamemode_manager = preload('res://scripts/gamemode_manager.gd')

#set up all gamemodes - everything in uppercase so that a simple rename can rename every reference of it
onready var REGULAR    = gamemode_manager.new("REGULAR")
onready var TELEPORT   = gamemode_manager.new("TELEPORT")
onready var BUMPERS    = gamemode_manager.new("BUMPERS")
onready var INTANGIBLE = gamemode_manager.new("INTANGIBLE")

onready var gamemodes = [REGULAR, TELEPORT, BUMPERS, INTANGIBLE]
#the current gamemode. will be shared through all objects.
onready var current_gamemode = REGULAR

func set_gamemode(gamemode_string):
	"""
	sets the gamemode object by its name.
	args:
		gamemodeString: The string representation of the gamemode. Must be in all caps.
	"""
	for gamemode in gamemodes:
		if gamemode.name() == gamemode_string:
			current_gamemode = gamemode


func get_gamemode(gamemode_string):
	"""
	Get the gamemode object by its name.
	args:
		gamemodeString: The string representation of the gamemode. Must be in all caps.
	returns:
		The specified gamemode.
	"""
	for gamemode in gamemodes:
		if gamemode.name() == gamemode_string:
			return gamemode

	return null