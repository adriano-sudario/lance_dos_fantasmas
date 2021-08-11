if (!audio_is_playing(audio) && !has_saved) {
	with (service)
		post_current_phantom();
	has_saved = true;
}