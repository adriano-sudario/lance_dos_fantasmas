var next_environment = get_next_environment();
sprite_index = next_environment.index;

with(vortex) {
	x = next_environment.vortex_position.x;
	y = next_environment.vortex_position.y;
}

with(game)
	current_environment = {
		index: other.sprite_index,
		vortex_position: next_environment.vortex_position,
		width: other.sprite_width,
		height: other.sprite_height,
	};

with(phantom) {
	var width = abs(sprite_width);
	var height = abs(sprite_height);
	var half_width = width / 2;
	var half_height = height / 2;
	randomize();
	x = irandom_range(half_width, game.current_environment.width - half_width);
	y = irandom_range(half_height, game.current_environment.height - half_height);
	image_blend = make_colour_rgb(random(255), random(255), random(255));
	var void_distance = point_distance(vortex.x, vortex.y, x, y);
	if (void_distance < vortex.gravity_radius) {
		var angle = point_direction(x, y, vortex.x, vortex.y);
		var x_force = lengthdir_x(vortex.gravity_radius - void_distance, angle);
		var y_force = lengthdir_y(vortex.gravity_radius - void_distance, angle);
		x -= x_force;
		y -= y_force;
	}
	
	global.current_phantom = {
		environment_index: game.current_environment.index,
		image_yscale: size,
		image_xscale: size,
		x: x,
		y: y,
		image_index: image_index,
		image_angle: image_angle,
		image_blend: image_blend,
		path: []
	};
}

with(camera_controller) {
	following = phantom;
	x = following.x;
	y = following.y;	
}