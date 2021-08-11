if (is_fading_in) {
	image_alpha += fading_speed;
	if (image_alpha >= 1) {
		is_fading_in = false;
		image_alpha = 1;
		with(vortex)
			is_shrinking = true;
	}
}

if (is_fading_out) {
	image_alpha -= fading_speed;
	
	if (image_alpha <= 0)
		instance_destroy();
}