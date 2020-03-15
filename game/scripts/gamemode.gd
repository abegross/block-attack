extends Node

onready var gamemode_manager = load('res://scripts/gamemode_manager.gd')

#set up all gamemodes - everything in uppercase so that a simple rename can rename every reference of it
onready var BUMPERS    = gamemode_manager.new("MODE1")
onready var REGULAR    = gamemode_manager.new("MODE2")
onready var INTANGIBLE = gamemode_manager.new("MODE3")
onready var TELEPORT   = gamemode_manager.new("MODE4")

onready var gamemodes	=	[REGULAR, TELEPORT, BUMPERS, INTANGIBLE]
onready var gamemode_names=	["BUMPERS", "REGULAR", "INTANGIBLE", "TELEPORT"]

#the current gamemode. will be shared through all objects.
onready var current_gamemode = REGULAR

func set_gamemode(gamemode_string):
	"""
	sets the gamemode object by its name.
	args:
		gamemodeString: The string representation of the gamemode. Must be in all caps.
	"""
	for gamemode in gamemodes:
		if gamemode.name().to_lower() == gamemode_string.to_lower():
			current_gamemode = gamemode
	for gamemode in gamemode_names:
		if gamemode.to_lower() == gamemode_string.to_lower():
			current_gamemode = gamemode


func get_gamemode(gamemode_string):
	"""
	Get the gamemode object by its name.
	args:
		gamemodeString: The string representation of the gamemode. Must be in all caps.
	returns:
		The specified gamemode.
	"""
	print(gamemode_string)
	for gamemode in gamemodes:
		if gamemode.name().to_lower() == gamemode_string.to_lower():
			return gamemode
	for gamemode in gamemode_names:
		if gamemode.to_lower() == gamemode_string.to_lower():
			return gamemode
	return null
