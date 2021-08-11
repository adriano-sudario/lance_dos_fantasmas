/// @function post_current_phantom()

function post_current_phantom() {
	if (global.audio == morrendo_na_praia_sound)
		return;
	
	var map = ds_map_create();
	ds_map_add(map, "Content-Type", "application/json");
	var data = json_stringify(global.current_phantom);
	post_request = http_request(ENDPOINT_URL, "POST", map, data);
	ds_map_destroy(map);
}