/// @function load_bot_phantoms()

function load_bot_phantoms() {
	if (global.previous_phantoms == noone)
		return;
	
	for (var i = 0; i < array_length(global.previous_phantoms); i++)
	{
		var memories = global.previous_phantoms[i];
		with (instance_create_layer(
			memories.x, memories.y, "Phantoms", previous_phantom))
			load(memories);
	}
}