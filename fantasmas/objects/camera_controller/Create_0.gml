camera = view_camera[0];
following = noone;
zooming = 1;
viewport = {
	half_width: camera_get_view_width(camera) * .5,
	half_height: camera_get_view_height(camera) * .5,
	full_width: camera_get_view_width(camera),
	full_height: camera_get_view_height(camera)
};
starting_viewport = {
	half_width: viewport.half_width,
	half_height: viewport.half_height,
	full_width: viewport.full_width,
	full_height: viewport.full_height
};

function zoom(_zooming) {
	viewport = {
		half_width: (starting_viewport.full_width * _zooming) * .5,
		half_height: (starting_viewport.full_height * _zooming) * .5,
		full_width: starting_viewport.full_width * _zooming,
		full_height: starting_viewport.full_height * _zooming
	};
	camera_set_view_size(camera, viewport.full_width, viewport.full_height);
}