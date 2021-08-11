environment_index = noone;
size = .25;
vanishing_speed = .01;
path = [];
previous_position = {
	x: 0,
	y: 0,
};
image_yscale = size;
image_xscale = size;

function load(_memories) {
	environment_index = _memories.environment_index;
	image_yscale = _memories.image_yscale;
	image_xscale = _memories.image_xscale;
	previous_position.x = _memories.x;
	previous_position.y = _memories.y;
	image_index = _memories.image_index;
	image_angle = _memories.image_angle;
	image_blend = _memories.image_blend;
	array_copy(path, 0, _memories.path, 0, array_length(_memories.path));
}