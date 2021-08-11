is_fading_in = false;
is_fading_out = false;
fading_speed = .01;

function start_transition() {
	if (is_fading_in || is_fading_out)
		return;
	
	with(instance_create_depth(0, 0, 1, environment)) {
		is_fading_out = true;
		sprite_index = other.sprite_index;
	}
	
	var next_environment = get_next_environment();
	sprite_index = next_environment.index;
	image_alpha = 0;
	is_fading_in = true;
	
	with(game)
		current_environment = {
			index: other.sprite_index,
			vortex_position: next_environment.vortex_position,
			width: other.sprite_width,
			height: other.sprite_height,
		};
}

function get_next_environment() {
	var environments = game.get_environments();
	
	if (sprite_index >= 0)
		for (var i = 0; i < array_length(environments); i++;) {
			if (environments[i].index == sprite_index) {
				array_delete(environments, i, 1);
				break;
			}
		}
	randomize();
	var next_environment_index = irandom(array_length(environments) - 1);
	var next_environment = environments[next_environment_index];
	return next_environment;
}