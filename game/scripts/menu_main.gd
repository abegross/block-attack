extends VBoxContainer

#onready var themeb = preload("res://theme.tres")
# func _ready() -> void:
	# TranslationServer.set_locale("ja")
var admob = null
var isReal = false
var isTop = false
var adBannerId = "ca-app-pub-4695032835472626/4212842488"
var adInterstitialId = "ca-app-pub-4695032835472626/5183692110"
var adRewardedId = "ca-app-pub-4695032835472626/7742051622"

func _ready():
#	color.randomizer([background, $btn_start, theme])
#	$title.font.set_size(120)
#	TranslationServer.set_locale("en")

#	print(theme.get_stylebox("normal", 'Button').bg_color)
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		if admob != null:
			admob.loadBanner(adBannerId, isTop)
			admob.loadInterstitial(adInterstitialId)
	pass
