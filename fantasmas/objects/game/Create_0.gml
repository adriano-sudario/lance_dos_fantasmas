#macro RESOLUTION_WIDTH 1028
#macro RESOLUTION_HEIGHT 720
#macro PREVIOUS_PHANTOMS_JSON "previous_phantoms.json"

has_saved = false;
current_environment = {
	index: 0,
	vortex_position: { x: 0, y: 0 },
	width: 0,
	height: 0,
};
load_bot_phantoms();

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);

function set_fullscreen(_value) {
	window_set_fullscreen(_value);
	with (camera_controller) {
		if (window_get_fullscreen()) {
			camera_set_view_size(camera, display_get_width(), display_get_height());
			view_set_wport(0, display_get_width());
			view_set_hport(0, display_get_height());
			surface_resize(application_surface,
				display_get_width(), display_get_height());
		} else {
			camera_set_view_size(camera, RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
			view_set_wport(0, RESOLUTION_WIDTH);
			view_set_hport(0, RESOLUTION_HEIGHT);
			surface_resize(application_surface,
				RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
		}
		
		viewport = {
			half_width: camera_get_view_width(camera) * .5,
			half_height: camera_get_view_height(camera) * .5,
			full_width: camera_get_view_width(camera),
			full_height: camera_get_view_height(camera)
		};
	}
}

function toggle_fullscreen() {
	set_fullscreen(!window_get_fullscreen());
}

function get_environments() {
	return [
		{ index: forest_sprite, vortex_position: { x: 1311, y: 630 } },
		{ index: room_sprite, vortex_position: { x: 1248, y: 288 } },
		{ index: space_sprite, vortex_position: { x: 880, y: 710 } }
	];
}

//function get_elapsed_ms() {
//	return delta_time * .001;
//}

is_play_na_maciota = false;

set_fullscreen(true);
audio = audio_play_sound(global.audio, 1, false);
audio_length = audio_sound_length(global.audio);

if (is_play_na_maciota)
	audio_sound_gain(audio, 0, 0);