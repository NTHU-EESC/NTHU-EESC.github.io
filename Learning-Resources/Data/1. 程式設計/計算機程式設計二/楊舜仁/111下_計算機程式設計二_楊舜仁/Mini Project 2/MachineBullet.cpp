#include <allegro5/base.h>
#include <random>
#include <string>

#include "DirtyEffect.hpp"
#include "Enemy.hpp"
#include "MachineBullet.hpp"
#include "Group.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"

class Turret;

MachineBullet::MachineBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent) :
    Bullet("play/bullet-6.png", 600, 5, position, forwardDirection, rotation - ALLEGRO_PI / 2, parent) {
    // TODO 3 (2/5): You can imitate the 2 files: 'WoodBullet.hpp', 'WoodBullet.cpp' to create a new bullet.
}
void MachineBullet::OnExplode(Enemy* enemy) {
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(2, 5);
    enemy->Slow(0.5, 3);
    getPlayScene()->GroundEffectGroup->AddNewObject(new DirtyEffect("play/dirty-1.png", dist(rng), enemy->Position.x, enemy->Position.y));
}
