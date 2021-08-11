with(camera_controller) {
	following = lonely_phantom;
	x = following.x;
	y = following.y;	
}

with(game)
	current_environment = {
		index: computer_room_sprite,
		width: sprite_get_width(computer_room_sprite),
		height: sprite_get_height(computer_room_sprite)
	};