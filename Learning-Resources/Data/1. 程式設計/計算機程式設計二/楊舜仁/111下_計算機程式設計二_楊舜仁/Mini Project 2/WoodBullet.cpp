#include <allegro5/base.h>
#include <random>
#include <string>

#include "DirtyEffect.hpp"
#include "Enemy.hpp"
#include "WoodBullet.hpp"
#include "Group.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"

class Turret;

WoodBullet::WoodBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent) :
    Bullet("play/bullet-8.png", 750, 2, position, forwardDirection, rotation - ALLEGRO_PI / 2, parent) {
    // TODO 3 (2/5): You can imitate the 2 files: 'WoodBullet.hpp', 'WoodBullet.cpp' to create a new bullet.
}
void WoodBullet::OnExplode(Enemy* enemy) {
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(2, 5);
    getPlayScene()->GroundEffectGroup->AddNewObject(new DirtyEffect("play/dirty-1.png", dist(rng), enemy->Position.x, enemy->Position.y));
}
