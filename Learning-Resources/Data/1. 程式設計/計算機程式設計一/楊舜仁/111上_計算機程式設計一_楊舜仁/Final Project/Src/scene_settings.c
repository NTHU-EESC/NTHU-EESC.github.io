// [HACKATHON 3-9]
// TODO: Create scene_settings.h and scene_settings.c.
// No need to do anything for this part. We've already done it for
// you, so this 2 files is like the default scene template.
#include "scene_settings.h"
#include "scene_menu.h"
#include "shared.h"
#include "utility.h"

// Variables and functions with 'static' prefix at the top level of a
// source file is only accessible in that file ("file scope", also
// known as "internal linkage"). If other files has the same variable
// name, they'll be different variables.

/* Define your static vars / function prototypes below. */

// TODO: More variables and functions that will only be accessed
// inside this scene. They should all have the 'static' prefix.

static ALLEGRO_SAMPLE_ID volume_BGM;

static void draw(void){
	al_clear_to_color(al_map_rgb(0, 0, 0));
	// settings problem
	char vol[30];
	sprintf(vol, "Vol: %.1f", music_volume);
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2,
		ALLEGRO_ALIGN_CENTER,
		vol);
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2 + 40,
		ALLEGRO_ALIGN_CENTER,
		"PRESS ESC TO GO BACK");
}

void destroy(void) {
	stop_bgm(volume_BGM);
}

static void on_key_down(int keycode) {

	switch (keycode) {
	case ALLEGRO_KEY_ESCAPE:
		stop_bgm(volume_BGM);
		game_change_scene(scene_menu_create());
		break;
	case ALLEGRO_KEY_LEFT:
		stop_bgm(volume_BGM);
		music_volume -= 0.1;
		effect_volume -= 0.1;
		if (music_volume < 0.0) music_volume = 0.0;
		if (effect_volume < 0.0) music_volume = 0.0;
		volume_BGM = play_bgm(themeMusic, music_volume);
		break;
	case ALLEGRO_KEY_RIGHT:
		stop_bgm(volume_BGM);
		music_volume += 0.1;
		effect_volume += 0.1;
		if (music_volume > 1.0) music_volume = 1.0;
		if (effect_volume > 1.0) music_volume = 1.0;
		volume_BGM = play_bgm(themeMusic, music_volume);
		break;
	case ALLEGRO_KEY_DOWN:
		stop_bgm(volume_BGM);
		music_volume -= 0.1;
		effect_volume -= 0.1;
		if (music_volume < 0.0) music_volume = 0.0;
		if (effect_volume < 0.0) music_volume = 0.0;
		volume_BGM = play_bgm(themeMusic, music_volume);
		break;
	case ALLEGRO_KEY_UP:
		stop_bgm(volume_BGM);
		music_volume += 0.1;
		effect_volume += 0.1;
		if (music_volume > 1.0) music_volume = 1.0;
		if (effect_volume > 1.0) music_volume = 1.0;
		volume_BGM = play_bgm(themeMusic, music_volume);
		break;
	
	default:
		return;
		break;
	}
	
	char vol[30];
	sprintf(vol, "Vol: %.1f", music_volume);
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2,
		ALLEGRO_ALIGN_CENTER,
		vol);
}

// The only function that is shared across files.
Scene scene_settings_create(void) {
	Scene scene;
	memset(&scene, 0, sizeof(Scene));
	scene.name = "Settings";
	scene.draw = &draw;
	scene.destroy = &destroy;
	// TODO: Register more event callback functions such as keyboard, mouse, ...
	scene.on_key_down = &on_key_down;
	game_log("Settings scene created");
	return scene;
}