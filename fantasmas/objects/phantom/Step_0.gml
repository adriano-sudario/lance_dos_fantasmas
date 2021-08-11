if (!audio_is_playing(game.audio)) {
	if (image_index > 2)
		image_index = 0;
	image_alpha -= vanishing_speed;
	if (image_alpha < 0)
		game_end();
	return;
}

if (vortex.is_swallowing) {
	current_size = max(0, current_size - shrink_speed);
	image_yscale = current_size;
	image_xscale = current_size * swallow_direction;
	return;
} else if (current_size < size) {
	current_size = min(current_size + growth_speed, size);
	image_yscale = current_size;
	image_xscale = current_size * swallow_direction;
	return;
}
var left = keyboard_check(ord("A"))
	|| keyboard_check(vk_left)
	|| gamepad_axis_value(0, gp_axislh) < -.5;
var right = keyboard_check(vk_right) 
	|| keyboard_check(ord("D")) 
	|| gamepad_axis_value(0, gp_axislh) > .5;
var horizontal_direction = right - left;

if (horizontal_direction != 0) {
	x += horizontal_direction * floating_speed;
	image_xscale = horizontal_direction * size;
}

var up = keyboard_check(ord("W"))
	|| keyboard_check(vk_up)
	|| gamepad_axis_value(0, gp_axislv) < -.5;
var down = keyboard_check(ord("S"))
	|| keyboard_check(vk_down)
	|| gamepad_axis_value(0, gp_axislv) > .5;
var vertical_direction = down - up;

if (vertical_direction != 0)
	y += vertical_direction * floating_speed;
	
var is_moving = horizontal_direction != 0 || vertical_direction != 0;

if (is_moving && image_index < 3)
	image_index = 3;
else if (!is_moving && image_index > 2)
	image_index = 0;

var half_width = abs(sprite_width) / 2;
var half_height = abs(sprite_height) / 2;
x = clamp(x, half_width, game.current_environment.width - half_width);
y = clamp(y, half_height, game.current_environment.height - half_height);

if (vortex.has_disappeared || vortex.is_respawning)
	return;

var void_distance = point_distance(vortex.x, vortex.y, x, y);
if (void_distance < vortex.gravity_radius) {
	var angle = point_direction(x, y, vortex.x, vortex.y);
	var force = vortex.gravity_force * (1 - (void_distance / vortex.gravity_radius));
	if (force == floating_speed)
		force++;
	var x_force = lengthdir_x(force, angle);
	var y_force = lengthdir_y(force, angle);
	x += x_force;
	y += y_force;
	
	if (sign(x_force) > 0 && x > vortex.x
		|| sign(x_force) < 0 && x < vortex.x)
		x = vortex.x;
		
	if (sign(y_force) > 0 && y > vortex.y
		|| sign(y_force) < 0 && y < vortex.y)
		y = vortex.y;
		
	if (point_distance(vortex.x, vortex.y, x, y) <= 1) {
		swallow_direction = sign(image_xscale);
		vortex.is_swallowing = true;
	}
	
	is_moving = true;
}