#include <allegro5/base.h>
#include <cmath>
#include <string>

#include "AudioHelper.hpp"
#include "Group.hpp"
#include "Miner.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"

const int Miner::Price = 50;
Miner::Miner(float x, float y) :
    // (1/5): You can imitate the 2 files: 'PlugGunTurret.hpp', 'PlugGunTurret.cpp' to create a new turret.
    Turret("play/tower-base.png", "play/miner.png", x, y, 0, Price, 0) {
    // Move center downward, since we the turret head is slightly biased upward
    // Anchor.y += 8.0f / GetBitmapHeight();
}

void Miner::CreateBullet() {}