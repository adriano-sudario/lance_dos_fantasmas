if (instance_exists(following)) {
	x += (following.x - x) / 25;
	y += (following.y - y) / 25;
}

x = clamp(x, viewport.half_width,
	game.current_environment.width - viewport.half_width);
y = clamp(y, viewport.half_height,
	game.current_environment.height - viewport.half_height);

camera_set_view_pos(camera, x - viewport.half_width, y - viewport.half_height);