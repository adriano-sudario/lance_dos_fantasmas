if (!audio_is_playing(game.audio))
	return;

var track_position = audio_sound_get_track_position(game.audio);

if (!is_swallowing && track_position > game.audio_length - 10) {
	has_disappeared = true;
	current_size = max(0, current_size - shrink_speed);
	return;
}

if (is_respawning) {
	current_size += growth_speed;
	if (current_size >= scale) {
		current_size = scale;
		is_respawning = false;
	}
}

if (has_disappeared) {
	current_respawn_frame++;
	if (current_respawn_frame >= respawn_frames_delay) {
		has_disappeared = false;
		is_respawning = true;
		current_respawn_frame = 0;
	}
	return;
}

if (is_swallowing) {
	if (is_shrinking) {
		current_size = max(0, current_size - shrink_speed);
		if (current_size <= 0)
			go_to_limbo();
	} else {
		current_size += growth_speed;
		if (current_size >= 3) {
			current_size = 3;
			with(environment)
				start_transition();
		}
	}
}

if (is_swallowing)
	rotation -= 4;
else
	rotation--;

if (rotation < -360)
	rotation = 0;