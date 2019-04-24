extends Node

var audio : AudioStreamPlayer
var lpf # low pass filter
var eq
var started = false

func _ready():
	audio = $exit_the_premises
	lpf = AudioServer.get_bus_effect(AudioServer.get_bus_index('Master'), 0)
	eq = AudioServer.get_bus_effect(AudioServer.get_bus_index('Master'), 2)
#	var e = AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Master'))

#func _process(delta):
#	print(AudioServer.get_bus_volume_db(AudioServer.get_bus_index('Master')))


"""
toggles the audio on and off
"""
func toggle_pause():
	if  audio.stream_paused:
		audio.set_stream_paused(false)
	else:
		audio.set_stream_paused(true)


"""
Make the music stop and do a cool stopping effect
"""
func death_sound():
	transition_sound(0.0, 500)
#	toggle_pause()


"""
Make the music start and do a cool starting up effect
"""
func start_sound():
	if not started:
		audio.play()
		started = true
#	else:
#		toggle_pause()
	transition_sound(1.0, 10000)


"""
change the pitch of the music over half a second
args:
	new_pitch: the new pitch to give the music/transition the music to
	new_lpf: the new highest allowed hz
"""
func transition_sound(new_pitch, new_lpf):
#	I need temporary variables to hold the items that will get lerped so that when lerping it should use the initial value and not the current value.
	var original_pitch = audio.pitch_scale
	var original_lpf   = lpf.cutoff_hz

	var transition_time = 0.5
	var elapsed_time = 0.0
	while elapsed_time < transition_time:
		audio.pitch_scale = lerp(original_pitch, new_pitch, elapsed_time/transition_time);
		lpf.cutoff_hz = lerp(original_lpf, new_lpf, elapsed_time/transition_time);
		elapsed_time += get_process_delta_time()
		yield(get_tree(), 'idle_frame')

#	the Lerp doesn't go all the way to the end, so this will finish it off
	audio.pitch_scale = new_pitch
	lpf.cutoff_hz = new_lpf
