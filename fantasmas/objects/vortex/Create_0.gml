#macro COLOUR_FOR_NO_MOVE make_colour_rgb(127,127,255)

distortion_stage = shader_get_sampler_index(distortion_shader, "distortion_texture_page"); 

application_surface_draw_enable(false);

rotation = 0;
scale = .25;
current_size = scale;
growth_speed = .025;
is_shrinking = false;
shrink_speed = .025;
gravity_force = 6;
gravity_radius = ((sprite_get_width(vortex_shader_sprite) + 
	sprite_get_height(vortex_shader_sprite)) / 2) * scale;
is_swallowing = false;
respawn_frames_delay = 0;
current_respawn_frame = 0;
is_respawning = false;
has_disappeared = false;
camera = camera_controller;

function go_to_limbo() {
	has_disappeared = true;
	is_swallowing = false;
	is_shrinking = false;
	x = game.current_environment.vortex_position.x;
	y = game.current_environment.vortex_position.y;
}