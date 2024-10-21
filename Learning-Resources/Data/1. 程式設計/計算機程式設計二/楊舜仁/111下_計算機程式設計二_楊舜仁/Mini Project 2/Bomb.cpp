#include <allegro5/base.h>
#include <cmath>
#include <string>

#include "AudioHelper.hpp"
#include "Group.hpp"
#include "Bomb.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"

const int Bomb::Price = 0;
Bomb::Bomb(float x, float y) :
    // (1/5): You can imitate the 2 files: 'PlugGunTurret.hpp', 'PlugGunTurret.cpp' to create a new turret.
    Turret("play/tower-base.png", "play/bomb.png", x, y, 0, Price, 0) {
}

void Bomb::CreateBullet() {
    // HoHoHo
    // HaHaHa
    // HeHeHe
}