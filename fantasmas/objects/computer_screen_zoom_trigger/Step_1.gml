if (place_meeting(x, y, lonely_phantom)) {
	zooming = max(zooming - zooming_speed, max_zoom);
	with(camera_controller) {
		following = computer_screen;
		zoom(other.zooming);
	}
} else {
	zooming = min(zooming + zooming_speed, 1);
	with(camera_controller) {
		following = lonely_phantom;
		zoom(other.zooming);
	}
}