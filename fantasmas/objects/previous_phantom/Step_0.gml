if (!audio_is_playing(game.audio)) {
	if (image_index > 2)
		image_index = 0;
	image_alpha -= vanishing_speed;
	if (image_alpha < 0)
		instance_destroy();
	return;
}

var index = array_find_index(path, function(p) {
	var track_position = audio_sound_get_track_position(game.audio);
	return p.audio_time <= track_position;
});

if (index != noone) {
	var current_path = path[index];
	previous_position.x = x;
	previous_position.y = y;
	x = current_path.x;
	y = current_path.y;
	environment_index = current_path.environment_index;
	image_yscale = current_path.image_yscale;
	image_xscale = current_path.image_xscale;
	image_angle = current_path.image_angle;
	array_delete(path, 0, index + 1);
}

var is_on_environment = false;
for (var i = 0; i < instance_number(environment); ++i;)
{
	var environment_instance = instance_find(environment, i);
	if (environment_instance.sprite_index == environment_index) {
		image_alpha = environment_instance.image_alpha;
		is_on_environment = true;
		break;
	}
}

if (!is_on_environment)
	image_alpha = 0;
	
var is_moving = previous_position.x != x || previous_position.y != y;

if (is_moving && image_index < 3)
	image_index = 3;
else if (!is_moving && image_index > 2)
	image_index = 0;