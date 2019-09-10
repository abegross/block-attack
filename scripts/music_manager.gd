extends Node

var audio : AudioStreamPlayer
#var playback
var lpf # low pass filter
var eq
var started = false
var muted = false setget toggle_mute

func _ready():
# 	var increment = (1.0 / (hz / pulse_hz))
#	var to_fill = playback.get_frames_available()
#	while (to_fill > 0):
#		playback.push_frame( Vector2(1.0,1.0) * sin(phase * (PI * 2.0))
#		phase = fmod((phase + increment), 1.0)
#		to_fill-=1;
	audio = $risen
	lpf = AudioServer.get_bus_effect(AudioServer.get_bus_index('Master'), 0)
	eq = AudioServer.get_bus_effect(AudioServer.get_bus_index('Master'), 2)
#	var e = AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Master'))

#func _process(delta):
#	print(AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Master')))

#var pressed : bool = true
#func _input(event: InputEvent) -> void:
#	if Input.is_action_just_pressed("press") and pressed:
#		death_sound()
#		pressed = not pressed
#		print(pressed)
#	elif Input.is_action_just_pressed("press") and not pressed:
#		start_sound()
#		pressed = not pressed
#		print(pressed)

func toggle_mute(_muted):
	muted = _muted
	toggle_pause()

"""
toggles the audio on and off
"""
func toggle_pause():
	if audio.stream_paused:
		audio.set_stream_paused(false)
	else:
		audio.set_stream_paused(true)


"""
Make the music stop and do a cool stopping effect
args:
	wait_time: how long the death time should take
"""
func death_sound(wait_time):
	if not muted:
		transition_sound(0.0, 0, true, wait_time)
#		toggle_pause()


"""
Make the music start and do a cool starting up effect
"""
func start_sound():
	if not muted:
	#	if not started:
	#		audio.play()
	#		started = true
	#	else:
		audio.set_stream_paused(false)
		transition_sound(1.0, 10000, false, 0.5)


"""
change the pitch of the music over half a second
args:
	new_pitch: the new pitch to give the music/transition the music to
	new_lpf: the new highest allowed hz
	pause: if true, audio will pause after the transition
	transition_time: the amount of time that the transition should take
"""
func transition_sound(new_pitch, new_lpf, pause, transition_time):
#	I need temporary variables to hold the items that will get lerped so that when lerping it should use the initial value and not the current value.
	var original_pitch = audio.pitch_scale
	var original_lpf   = lpf.cutoff_hz

	var elapsed_time = 0.0
	while elapsed_time < transition_time:
#Let's say we want to move the variable X between points A and B in N steps
		var v = elapsed_time/transition_time
		v = sqrt(v)
		audio.pitch_scale = lerp(original_pitch, new_pitch, v)
		lpf.cutoff_hz = lerp(original_lpf, new_lpf, v)
#		audio.pitch_scale = (original_pitch * v) + (new_pitch * (1-v))
#		lpf.cutoff_hz = (original_lpf * v) + (new_lpf * (1-v))
		elapsed_time += get_process_delta_time()
#		print(elapsed_time)
		yield(get_tree(), 'idle_frame')

#	the Lerp doesn't go all the way to the end, so this will finish it off
	audio.pitch_scale = new_pitch
	lpf.cutoff_hz = new_lpf
	if pause: audio.set_stream_paused(true)
