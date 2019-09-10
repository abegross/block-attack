tool
extends Button

export (String, 'REGULAR', 'TELEPORT', 'BUMPERS', 'INTANGIBLE') var mode setget _update

func _update(_mode):
	mode = _mode
	# if the script is not running in the editor wait for the nodes to be added to the tree
	if !Engine.editor_hint:
		yield(self, 'tree_entered')
	self.text = mode

# func _ready():

func _pressed():
	gamemode.set_gamemode(mode)