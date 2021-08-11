/// @function save_previous_phantoms()

function save_previous_phantoms() {
	array_push(global.previous_phantoms, global.current_phantom);
	var length = array_length(global.previous_phantoms);
	if (length > 9)
		array_delete(global.previous_phantoms, 0, length - 9);
	var file = file_text_open_write(PREVIOUS_PHANTOMS_JSON);
	file_text_write_string(file, json_stringify(global.previous_phantoms));
	file_text_close(file);
	
	//var json_previous_phantoms = json_stringify(global.previous_phantoms);
	//var length = 0;
	//for (var i = 0; i < string_length(json_previous_phantoms); i++)
	//	length += 8;
	//var buff = buffer_create(length, buffer_fixed, 1);
	//buffer_write(buff, buffer_text, json_previous_phantoms);
	//var compressed_buff = buffer_compress(buff, 0, buffer_tell(buff));
	//buffer_save(compressed_buff, "save.bin");
	//buffer_delete(buff);
	//buffer_delete(compressed_buff);
}