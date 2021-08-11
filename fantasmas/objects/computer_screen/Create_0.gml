surfacePPTemp1 = -1;
surfacePPTemp2 = -1;
surfacePPTemp3 = -1;
size = .26;
photos = [
	photo1_sprite,
	photo2_sprite,
	photo3_sprite,
	photo4_sprite,
	photo5_sprite,
];
current_photo = 0;
next_delay = 60 * 3;
current_delay_frame = 0;
sprite_index = photos[current_photo];
image_xscale = size;
image_yscale = size;

function next_photo() {
	current_photo++;
	if (current_photo >= array_length(photos))
		current_photo = 0;
	sprite_index = photos[current_photo];
}