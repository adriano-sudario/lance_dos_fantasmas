if (global.previous_phantoms == noone) {
	global.audio = morrendo_na_praia_sound;
	room_goto(LonelyRoom);
} else {
	global.audio = passeio_sound;
	room_goto(Walkway);
}