var is_successful = ds_map_find_value(async_load, "status") == 0;
if (!is_successful)
	return;

if (ds_map_find_value(async_load, "id") == get_request) {
	var request_result = ds_map_find_value(async_load, "result");
	global.previous_phantoms = json_parse(request_result);
} else if (ds_map_find_value(async_load, "id") == post_request) {
	save_previous_phantoms();
}