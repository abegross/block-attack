extends VBoxContainer
var panel
func _ready():
	panel = $'../../../panel'
	for score in get_tree().get_nodes_in_group('score'):
		score.connect('show_hs', self, '_score_pressed')
#	panel.show()

#	add_scores()

func _process(delta):
#	print(panel)
	pass


func _score_pressed(gm):
#	panel.margin_left = 100
#	panel.margin_top = 100
#	panel.margin_right = 980
#	panel.margin_bottom = 1820
#	for child in get_children():
#		if child is HBoxContainer:
#			child.queue_free()
	var hss = gamemode.get_gamemode(gm).get_highscores()
#	hss.invert()
	var i = 0
	for child in get_tree().get_nodes_in_group('hs'):
#	for hs in len(hss):
#		var hbox :HBoxContainer= HBoxContainer.new()
#		var time :Label= Label.new()
#		var score :Label= Label.new()
#
#		time.size_flags_horizontal = time.SIZE_EXPAND
#		score.size_flags_horizontal = score.SIZE_SHRINK_END
		print(hss)
		if str(hss[i][1]) == "0":
			hss[i][1] = ' \\\\\\\\-\\\\-\\\\'
		child.get_node('date').text = (' '+str(hss[i][1]))
		child.get_node('score').text = str(hss[i][0])+' '
		print(hss[i][1])
		i += 1
#		print()
#		hbox.add_child(time)
#		hbox.add_child(score)
#		add_child_below_node($desc, hbox)
	panel.show()
