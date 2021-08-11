if (!audio_is_playing(game.audio))
	return;

array_push(global.current_phantom.path,  {
	environment_index: game.current_environment.index,
	image_yscale: image_yscale,
	image_xscale: image_xscale,
	x: x,
	y: y,
	image_angle: image_angle,
	audio_time: audio_sound_get_track_position(game.audio)
});