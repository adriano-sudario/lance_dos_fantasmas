current_delay_frame++;

if (current_delay_frame > next_delay) {
	current_delay_frame = 0;
	next_photo();
}