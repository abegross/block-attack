extends Node

# constants for the HSP scale
const Pr = .299
const Pg = .587
const Pb = .114

var color = Color()

func _ready():
	randomize()
	color_randomize()

func color_randomize():
	#New color, the order MUST be set in V,S,H, this is because Color
	#only saves RGB values, it does not save HSV values.
	color = HSPtoRGB(rand_range(0, 1), rand_range(0.4, 0.8), 0.75)

func randomizer(array = null) -> Color:
	color_randomize()

#	for item in array:
#		if item is Color:
#			item = color
#		elif item is Theme:
#			item.set_color("font_color", "Button", color)
#			item.set_color("font_color", "Label", color)
#		elif item is Button:
#			var stylebox = StyleBoxFlat.new()
#			stylebox.bg_color = color
##					print(color)
#			item.theme.set_stylebox('normal', 'Button', stylebox)
##					stylebox.bg_color = color.darkened(0.2)
#			item.theme.set_stylebox('hover', 'Button', stylebox)
##					stylebox.bg_color = color.darkened(0.3)
#			item.theme.set_stylebox('pressed', 'Button', stylebox)
##					subitem.get_stylebox("normal", 'Button').bg_color = color
##					print(subitem.get_stylebox('normal').bg_color)
#			item.get_stylebox("hover", 'Button').bg_color = color.darkened(0.2)
##					print(color.darkened(0.2))
#			item.get_stylebox("pressed", 'Button').bg_color = color.darkened(0.3)
#		elif item is Panel:
#			var stylebox = StyleBoxFlat.new()
#			stylebox.bg_color = color
#			item.theme.set_stylebox('panel', 'Panel', stylebox)
#		elif item is Array:
#			for subitem in item:
#				if subitem is Color:
#					subitem = color
#				elif subitem is Theme:
#					subitem.set_color("font_color", "Button", color)
#					subitem.set_color("font_color", "Label", color)
#				elif subitem is Button:
#					var stylebox = StyleBoxFlat.new()
#					stylebox.bg_color = color
##					print(color)
#					subitem.theme.set_stylebox('normal', 'Button', stylebox)
##					stylebox.bg_color = color.darkened(0.2)
#					subitem.theme.set_stylebox('hover', 'Button', stylebox)
##					stylebox.bg_color = color.darkened(0.3)
#					subitem.theme.set_stylebox('pressed', 'Button', stylebox)
##					subitem.get_stylebox("normal", 'Button').bg_color = color
##					print(subitem.get_stylebox('normal').bg_color)
#					subitem.get_stylebox("hover", 'Button').bg_color = color.darkened(0.2)
##					print(color.darkened(0.2))
#					subitem.get_stylebox("pressed", 'Button').bg_color = color.darkened(0.3)
#				elif subitem is Panel:
##					print(subitem.theme.get_stylebox_types())
##					print(subitem.them.get_stylebox_list('panel'))
#					var stylebox = StyleBoxFlat.new()
#					stylebox.bg_color = color
#					subitem.theme.set_stylebox('panel', 'Panel', stylebox)
#				elif subitem is Theme:
#					var stylebox = StyleBoxFlat.new()
#					stylebox.bg_color = color
#					subitem.set_stylebox('panel', 'Panel', stylebox)
#				elif subitem is Array:
#					for subsubitem in subitem:
#						subsubitem.set_modulate(color)
#				elif subitem.has_node('sprite'):
#					subitem.get_node('sprite').set_modulate(color)
#				else:
#					subitem.set_modulate(color)
#		else:
#			item.self_modulate = Color(1,1,1,1)
#			item.self_modulate = color
#
#		color.h += 1.0/len(array)
#		if color.h > 1: color.h = color.h - 1
#		if item is ColorRect:
#			item.set_modulate('#ffffff')
	return color


func RGBtoHSP(new_color):
  var R = new_color.r
  var G = new_color.g
  var B = new_color.b
  var H
  var S
  var P
  #	Calculate the Perceived brightness.
  P=sqrt(R*R*Pr+G*G*Pg+B*B*Pb)


  #  Calculate the Hue and Saturation.  (This part works
  #  the same way as in the HSV/B and HSL systems???.)
  if      (R==G && R==B):
    H=0.0; S=0.0; return;
  if (R>=G && R>=B):   #  R is largest
    if (B>=G):
      H=6.0/6.0-1.0/6.0*(B-G)/(R-G); S=1.0-G/R;
    else:
      H=0.0/6.0+1.0/6.0*(G-B)/(R-B); S=1.0-B/R;
  elif (G>=R && G>=B):   #  G is largest
    if    (R>=B):
      H=2.0/6.0-1.0/6.0*(R-B)/(G-B); S=1.0-B/G;
    else:
      H=2.0/6.0+1.0/6.0*(B-R)/(G-R); S=1.0-R/G;
  else:   #  B is largest
    if    (G>=R):
      H=4.0/6.0-1.0/6.0*(G-R)/(B-R); S=1.0-R/B;
    else:
      H=4.0/6.0+1.0/6.0*(R-G)/(B-G); S=1.0-G/B;
  return [H, S, P]

func HSPtoRGB(H, S, P):
  var R
  var G
  var B

  var part
  var minOverMax=1.0-S ;

  if (minOverMax>0.0):
    if      ( H<1.0/6.0):   #  R>G>B
      H= 6.0*( H-0.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      B=P/sqrt(Pr/minOverMax/minOverMax+Pg*part*part+Pb);
      R=(B)/minOverMax; G=(B)+H*((R)-(B));
    elif ( H<2.0/6.0):   #  G>R>B
      H= 6.0*(-H+2.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      B=P/sqrt(Pg/minOverMax/minOverMax+Pr*part*part+Pb);
      G=(B)/minOverMax; R=(B)+H*((G)-(B));
    elif ( H<3.0/6.0):   #  G>B>R
      H= 6.0*( H-2.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      R=P/sqrt(Pg/minOverMax/minOverMax+Pb*part*part+Pr);
      G=(R)/minOverMax; B=(R)+H*((G)-(R));
    elif ( H<4.0/6.0):   #  B>G>R
      H= 6.0*(-H+4.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      R=P/sqrt(Pb/minOverMax/minOverMax+Pg*part*part+Pr);
      B=(R)/minOverMax; G=(R)+H*((B)-(R));
    elif ( H<5.0/6.0):   #  B>R>G
      H= 6.0*( H-4.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      G=P/sqrt(Pb/minOverMax/minOverMax+Pr*part*part+Pg);
      B=(G)/minOverMax; R=(G)+H*((B)-(G));
    else              :   #  R>B>G
      H= 6.0*(-H+6.0/6.0); part=1.0+H*(1.0/minOverMax-1.0);
      G=P/sqrt(Pr/minOverMax/minOverMax+Pb*part*part+Pg);
      R=(G)/minOverMax; B=(G)+H*((R)-(G));
  else:
    if      ( H<1.0/6.0):   #  R>G>B
      H= 6.0*( H-0.0/6.0); R=sqrt(P*P/(Pr+Pg*H*H)); G=(R)*H; B=0.0;
    elif ( H<2.0/6.0):   #  G>R>B
      H= 6.0*(-H+2.0/6.0); G=sqrt(P*P/(Pg+Pr*H*H)); R=(G)*H; B=0.0;
    elif ( H<3.0/6.0):   #  G>B>R
      H= 6.0*( H-2.0/6.0); G=sqrt(P*P/(Pg+Pb*H*H)); B=(G)*H; R=0.0;
    elif ( H<4.0/6.0):   #  B>G>R
      H= 6.0*(-H+4.0/6.0); B=sqrt(P*P/(Pb+Pg*H*H)); G=(B)*H; R=0.0;
    elif ( H<5.0/6.0):   #  B>R>G
      H= 6.0*( H-4.0/6.0); B=sqrt(P*P/(Pb+Pr*H*H)); R=(B)*H; G=0.0;
    else              :   #  R>B>G
      H= 6.0*(-H+6.0/6.0); R=sqrt(P*P/(Pr+Pb*H*H)); B=(R)*H; G=0.0;
#	color = Color(R, G, B)
  return Color(R, G, B)