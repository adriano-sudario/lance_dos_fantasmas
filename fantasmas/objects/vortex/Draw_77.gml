surface_distort = 
	surface_create(camera.viewport.full_width, camera.viewport.full_height);
surface_set_target(surface_distort);

draw_clear_alpha(COLOUR_FOR_NO_MOVE, 0);

var axis_x = x - camera.x + camera.viewport.half_width;
var axis_y = y - camera.y + camera.viewport.half_height;
draw_sprite_ext(vortex_shader_sprite, 0, axis_x, axis_y,
	current_size, current_size, rotation, c_white, 1);

surface_reset_target();

var surface_texture_page = surface_get_texture(surface_distort);
shader_set(distortion_shader);
texture_set_stage(distortion_stage, surface_texture_page);
draw_surface(application_surface, 0, 0);

shader_reset();
surface_free(surface_distort);