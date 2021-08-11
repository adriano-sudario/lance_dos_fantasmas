#macro ENDPOINT_URL "https://localhost:44367/api/phantom"

global.previous_phantoms = noone;
post_request = noone;
get_request = http_get(ENDPOINT_URL);