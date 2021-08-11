if (!audio_is_playing(game.audio)) {
	if (image_index > 2)
		image_index = 0;
	image_alpha -= vanishing_speed;
	if (image_alpha < 0)
		game_end();
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