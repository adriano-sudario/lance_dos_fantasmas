/// @function array_find_index(array, assertion, send_back_object)

function array_find_index(_array, _assertion){
	var index = noone;
	
	for (var i = 0; i < array_length(_array); i++) {
		var has_found = argument_count > 2 ? _assertion(_array[i], argument[2]) :
			_assertion(_array[i]);
		if (has_found) {
			index = i;
			break;
		}
	}
		
	return index;
}