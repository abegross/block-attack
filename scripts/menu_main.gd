extends VBoxContainer

#onready var themeb = preload("res://theme.tres")

#var admob = null
#var isReal = false
#var isTop = true
#var adBannerId = "ca-app-pub-3940256099942544/6300978111" # [Replace with your Ad Unit ID and delete this message.]
#var adInterstitialId = "ca-app-pub-3940256099942544/8691691433" # [Replace with your Ad Unit ID and delete this message.]
#var adRewardedId = "ca-app-pub-3940256099942544/5224354917" # [There is no testing option for rewarded videos, so you can use this id for testing]

#func _ready():
#	color.randomizer([background, $btn_start, theme])
#	$title.font.set_size(120)

#	print(theme.get_stylebox("normal", 'Button').bg_color)
#	if(Engine.has_singleton("AdMob")):
#		admob = Engine.get_singleton("AdMob")
#		admob.init(isReal, get_instance_id())
#		if admob != null:
#			admob.loadBanner(adBannerId, isTop)