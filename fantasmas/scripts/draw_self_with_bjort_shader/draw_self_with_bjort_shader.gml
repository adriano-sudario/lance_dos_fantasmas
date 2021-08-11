
/// @function draw_self_with_bjort_shader()

function draw_self_with_bjort_shader() {
	var has_tex_filter = true;
	var res_mult = 0;
	var color_amt = 256;
	var distortion = 1;
	var reflection = 0.2;
	var shadow_mask = 0.4;
	var scanline = 0.6;
	var bleed = 0.3;
	var bleed_size = 16;
	var tint = 0.15;
	var vignette = 0.15;
	var film_grain = 0.15;
	var brightness = 0.23;
	var contrast = 1.0;
	var specular_r = 0.9;
	var specular_g = 0.85;
	var specular_b = 1.0;
	var specular_amp = 0.2;
	var specular_off_x = 0.15;
	var specular_off_y = -0.15;
	var glow_factor = 0.5;
	var glow_tint = 0.5;
	var blur_size = 8;
	var blur_zoom = 0.3;

	var is_shader_ok = shader_is_compiled(shd_retroscreen_screenfilter);
	is_shader_ok &= shader_is_compiled(shd_retroscreen_distortion);
	is_shader_ok &= shader_is_compiled(shd_retroscreen_postprocessing);

	if (!is_shader_ok)
	{
	    show_message("Whoops, seems like the program has failed to compile the shaders...#This program requires a graphics card that supports Shaders!#(You could also, install / update your DirectX drivers and try again to see if it works.)");
	    game_end();
	}
	
	var _time = current_time * 0.001;
	
	var width = sprite_width, height = sprite_height;
	if (res_mult > 0) {
		width *= res_mult;
		height *= res_mult;
	}

	if (!surface_exists(surfacePPTemp1))
		surfacePPTemp1 = surface_create(sprite_width, sprite_height);

	if (!surface_exists(surfacePPTemp2))
		surfacePPTemp2 = surface_create(sprite_width, sprite_height);

	if (!surface_exists(surfacePPTemp3))
		surfacePPTemp3 = surface_create(sprite_width, sprite_height);

	var _texnoise = sprite_get_texture(texBluenoise, 0);
	var _texshadowmask = sprite_get_texture(texShadowMask, 0);
	var _texrainbowlut = sprite_get_texture(texRainbowLUT, 0);
	var _texnoisetexelw = texture_get_texel_width(_texnoise);
	var _texnoisetexelh = texture_get_texel_height(_texnoise);
	var _texshadowmasktexelw = texture_get_texel_width(_texshadowmask);
	var _texshadowmasktexelh = texture_get_texel_height(_texshadowmask);

	surface_set_target(surfacePPTemp1);

	shader_set(shd_retroscreen_screenfilter);

	var _u_time                 = shader_get_uniform(shd_retroscreen_screenfilter, "uTime");
	var _u_shadowmaskintensity  = shader_get_uniform(shd_retroscreen_screenfilter, "uShadowmaskIntensity");
	var _u_scanlineintensity    = shader_get_uniform(shd_retroscreen_screenfilter, "uScanlineIntensity");
	var _u_bleendintensity      = shader_get_uniform(shd_retroscreen_screenfilter, "uBleedIntensity");
	var _u_bleendsize           = shader_get_uniform(shd_retroscreen_screenfilter, "ubleed_size");
	var _u_tintintensity        = shader_get_uniform(shd_retroscreen_screenfilter, "uTintIntensity");
	var _u_vignetteintensity    = shader_get_uniform(shd_retroscreen_screenfilter, "uVignetteIntensity");
	var _u_grainintensity       = shader_get_uniform(shd_retroscreen_screenfilter, "uFilmgrainIntensity");
	var _u_brightness           = shader_get_uniform(shd_retroscreen_screenfilter, "uBrightness");
	var _u_contrast             = shader_get_uniform(shd_retroscreen_screenfilter, "uContrast");
	var _u_screentexelsize      = shader_get_uniform(shd_retroscreen_screenfilter, "uScreenTexelSize");
	var _u_noisetexelsize       = shader_get_uniform(shd_retroscreen_screenfilter, "uNoiseTexelSize");
	var _u_shadowmasktexelsize  = shader_get_uniform(shd_retroscreen_screenfilter, "uShadowmaskTexelSize");
	var _u_colorlimit = shader_get_uniform(shd_retroscreen_screenfilter, "uColorLimit");
	var _samp_noise      = shader_get_sampler_index(shd_retroscreen_screenfilter, "uTexNoise");
	var _samp_shadowmask = shader_get_sampler_index(shd_retroscreen_screenfilter, "uTexShadowmask");
	shader_set_uniform_f(_u_time, _time);
	shader_set_uniform_f(_u_shadowmaskintensity, shadow_mask);
	shader_set_uniform_f(_u_scanlineintensity, scanline);
	shader_set_uniform_f(_u_bleendintensity, bleed);
	shader_set_uniform_f(_u_bleendsize, bleed_size);
	shader_set_uniform_f(_u_tintintensity, tint);
	shader_set_uniform_f(_u_vignetteintensity, vignette);
	shader_set_uniform_f(_u_grainintensity, film_grain);
	shader_set_uniform_f(_u_brightness, brightness);
	shader_set_uniform_f(_u_contrast, contrast);
	shader_set_uniform_f(_u_screentexelsize, 1 / sprite_width, 1 / sprite_height);
	shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh);
	shader_set_uniform_f(_u_shadowmasktexelsize, _texshadowmasktexelw, _texshadowmasktexelh);
	shader_set_uniform_f(_u_colorlimit, color_amt);
	texture_set_stage(_samp_noise, _texnoise);
	texture_set_stage(_samp_shadowmask, _texshadowmask);

	draw_sprite_ext(sprite_index, image_index, sprite_xoffset, sprite_yoffset,
	                image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	shader_reset();
	surface_reset_target();

	if (has_tex_filter) gpu_set_texfilter(true);

	surface_set_target(surfacePPTemp2);

	shader_set(shd_retroscreen_distortion);
	var _u_time                 = shader_get_uniform(shd_retroscreen_distortion, "uTime");
	var _u_distortionintensity  = shader_get_uniform(shd_retroscreen_distortion, "uScreenDistortIntensity");
	var _u_reflectionintensity  = shader_get_uniform(shd_retroscreen_distortion, "uBorderReflectionIntensity");
	var _u_specularcol          = shader_get_uniform(shd_retroscreen_distortion, "uSpecularLight");
	var _u_specularpos          = shader_get_uniform(shd_retroscreen_distortion, "uSpecularLightOffset");
	var _u_screentexelsize      = shader_get_uniform(shd_retroscreen_distortion, "uScreenTexelSize");
	var _u_noisetexelsize       = shader_get_uniform(shd_retroscreen_distortion, "uNoiseTexelSize");
	var _samp_noise             = shader_get_sampler_index(shd_retroscreen_distortion, "uTexNoise");
	shader_set_uniform_f(_u_time, _time);
	shader_set_uniform_f(_u_distortionintensity, distortion);
	shader_set_uniform_f(_u_reflectionintensity, reflection);

	shader_set_uniform_f(_u_specularcol, specular_r, specular_g, specular_b, specular_amp);
	shader_set_uniform_f(_u_specularpos, specular_off_x, specular_off_y);
	shader_set_uniform_f(_u_screentexelsize, 1 / sprite_width, 1 / sprite_height);
	shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh);
	texture_set_stage(_samp_noise, _texnoise);

	draw_surface(surfacePPTemp1, 0, 0);

	shader_reset();
	surface_reset_target();

	surface_set_target(surfacePPTemp3);
	draw_clear(c_black);

	shader_set(shd_retroscreen_postprocessing);
	var _u_time             = shader_get_uniform(shd_retroscreen_postprocessing, "uTime");
	var _u_glowfactor       = shader_get_uniform(shd_retroscreen_postprocessing, "uGlowFactor");
	var _u_glowtint         = shader_get_uniform(shd_retroscreen_postprocessing, "uGlowTintIntensity");
	var _u_blursize         = shader_get_uniform(shd_retroscreen_postprocessing, "uBlurSize");
	var _u_blurzoom         = shader_get_uniform(shd_retroscreen_postprocessing, "uBlurZoomIntensity");
	var _u_screentexelsize  = shader_get_uniform(shd_retroscreen_postprocessing, "uScreenTexelSize");
	var _u_noisetexelsize   = shader_get_uniform(shd_retroscreen_postprocessing, "uNoiseTexelSize");
	var _samp_noise         = shader_get_sampler_index(shd_retroscreen_postprocessing, "uTexNoise");
	var _samp_rainbowlut    = shader_get_sampler_index(shd_retroscreen_postprocessing, "uTexRainbow");
	shader_set_uniform_f(_u_time, _time);
	shader_set_uniform_f(_u_glowfactor, glow_factor);
	shader_set_uniform_f(_u_glowtint, glow_tint);
	shader_set_uniform_f(_u_blursize, blur_size);
	shader_set_uniform_f(_u_blurzoom, blur_zoom);
	shader_set_uniform_f(_u_screentexelsize, 1 / sprite_width, 1 / sprite_height);
	shader_set_uniform_f(_u_noisetexelsize, _texnoisetexelw, _texnoisetexelh);
	texture_set_stage(_samp_noise, _texnoise);
	texture_set_stage(_samp_rainbowlut, _texrainbowlut);

	draw_surface(surfacePPTemp2, 0, 0);

	shader_reset();
	surface_reset_target();

	draw_surface(surfacePPTemp3, x - sprite_xoffset, y - sprite_yoffset);

	if (has_tex_filter) gpu_set_texfilter(false);
}