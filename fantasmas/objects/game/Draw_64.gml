//if (is_play_na_maciota) {
//	var track_position = audio_sound_get_track_position(audio);

//	draw_set_color(c_white);
//	draw_text(32, 32, string(track_position) + " / " + string(audio_length));
//}

//if (request_value != noone) {
//	draw_set_color(c_red);
//	draw_text(32, 32, request_value);
//}

var track_position = audio_sound_get_track_position(audio);

draw_set_color(c_white);
draw_text(32, 32, string(track_position) + " / " + string(audio_length));