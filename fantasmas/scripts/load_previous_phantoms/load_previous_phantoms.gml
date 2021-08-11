/// @function load_previous_phantoms()

function load_previous_phantoms() {
	if (!file_exists(PREVIOUS_PHANTOMS_JSON)) {
		global.previous_phantoms = [];
		return;
	}
	var file = file_text_open_read(PREVIOUS_PHANTOMS_JSON);
	global.previous_phantoms = json_parse(file_text_read_string(file));
	file_text_close(file);
	
	//var buffer = buffer_load("save.bin");
	//var decompressed_buffer = buffer_decompress(buffer);
	//var json_previous_phantoms = buffer_read(decompressed_buffer, buffer_string);
	//global.previous_phantoms = json_parse(json_previous_phantoms);
	//buffer_delete(buffer);
	//buffer_delete(decompressed_buffer);
	
	for (var i = 0; i < array_length(global.previous_phantoms); i++)
	{
		var memories = global.previous_phantoms[i];
		with (instance_create_layer(
			memories.x, memories.y, "Phantoms", previous_phantom))
			load(memories);
	}
}