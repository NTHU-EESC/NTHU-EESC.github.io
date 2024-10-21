#include <allegro5/base.h>
#include <cmath>
#include <string>
#include <iostream>

#include "AudioHelper.hpp"
#include "CoronaVirusBullet.hpp"
#include "Group.hpp"
#include "ChickenTurret.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"
#include "ShootEffect.hpp"

const int ChickenTurret::Price = 15;
ChickenTurret::ChickenTurret(float x, float y) :
    // (1/5): You can imitate the 2 files: 'PlugGunTurret.hpp', 'PlugGunTurret.cpp' to create a new turret.
    Turret("play/tower-base.png", "play/chicken.png", x, y, 150, Price, 10) {
    // Move center downward, since we the turret head is slightly biased upward
    // Anchor.y += 8.0f / GetBitmapHeight();
}
void ChickenTurret::CreateBullet() {}

void ChickenTurret::Update(float deltaTime) {
    PlayScene* scene = getPlayScene();
    imgBase.Position = Position;
    imgBase.Tint = Tint;
    if (!Preview) {
        for (auto n : scene->TowerGroup->GetObjects()) {
            if (n->Position.x <= Position.x + scene->BlockSize && n->Position.x >= Position.x - scene->BlockSize && n->Position.y <= Position.y + scene->BlockSize && n->Position.y >= Position.y - scene->BlockSize) {
                // std::cout << "power!!!\n";
                n->powerUp = true;
                // break;
            }
        }
        coolDown -= deltaTime;
        if (coolDown <= 0) {
            for (auto n : scene->TowerGroup->GetObjects()) {
                if (n->Position.x <= Position.x + scene->BlockSize && n->Position.x >= Position.x - scene->BlockSize && n->Position.y <= Position.y + scene->BlockSize && n->Position.y >= Position.y - scene->BlockSize) {
                    n->powerUp = false;
                    // break;
                }
            }
            float x = (Position.x - (float)scene->BlockSize / 2) / scene->BlockSize;
            float y = (Position.y - (float)scene->BlockSize / 2) / scene->BlockSize;
            scene->mapState[y][x] = scene->TILE_FLOOR; // TILE_FLOOR
            scene->TowerGroup->RemoveObject(this->GetObjectIterator());
        }
    }
}