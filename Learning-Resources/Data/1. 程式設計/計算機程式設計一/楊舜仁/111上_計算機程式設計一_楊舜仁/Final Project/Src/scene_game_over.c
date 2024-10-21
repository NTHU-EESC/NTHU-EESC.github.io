#include "scene_game_over.h"
#include "shared.h"
#include "scene_menu.h"
#include "scene_game.h"

static void draw(void) {
	al_clear_to_color(al_map_rgb(0, 0, 0));
	char result[20];
	if (win) {
		sprintf(result, "Win!");
	}
	else {
		sprintf(result, "Game Over!");
	}
	// win = false;
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2 - 80,
		ALLEGRO_ALIGN_CENTER,
		result);
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2 - 40,
		ALLEGRO_ALIGN_CENTER,
		"PRESS ENTER TO PLAY AGAIN");
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2,
		ALLEGRO_ALIGN_CENTER,
		"PRESS ESC TO GO TO MENU");
	char h_score[30];
	int ret = sprintf(h_score, "Highest Score: %d", highest_score);
	if (!ret) game_abort("highest score error");
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2 + 40,
		ALLEGRO_ALIGN_CENTER,
		h_score);
	char score[30];
	ret = sprintf(score, "Score: %d", game_main_Score);
	if (!ret) game_abort("score error");
	al_draw_text(menuFont,
		al_map_rgb(255, 255, 0),
		SCREEN_W / 2,
		SCREEN_H / 2 + 80,
		ALLEGRO_ALIGN_CENTER,
		score);
	// game_main_Score = 0;
}

static void on_key_down(int keycode) {

	switch (keycode) {
	case ALLEGRO_KEY_ENTER:
		game_change_scene(scene_main_create());
		win = false;
		break;
	case ALLEGRO_KEY_ESCAPE:
		game_change_scene(scene_menu_create());
		win = false;
		break;
	default:
		break;
	}
}

Scene scene_game_over_create(void) {
	Scene scene;
	memset(&scene, 0, sizeof(Scene));
	scene.name = "Game_over";
	scene.draw = &draw;
	// TODO: Register more event callback functions such as keyboard, mouse, ...
	scene.on_key_down = &on_key_down;
	game_log("Win scene created");
	return scene;
}