#include <allegro5/base.h>
#include <cmath>
#include <string>
#include <iostream>

#include "AudioHelper.hpp"
#include "CoronaVirusBullet.hpp"
#include "Group.hpp"
#include "CoronaVirusTurret.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"
#include "ShootEffect.hpp"

const int CoronaVirusTurret::Price = 20;
CoronaVirusTurret::CoronaVirusTurret(float x, float y) :
    // (1/5): You can imitate the 2 files: 'PlugGunTurret.hpp', 'PlugGunTurret.cpp' to create a new turret.
    Turret("play/tower-base.png", "play/turret-4.png", x, y, 150, Price, 1.5) {
    // Move center downward, since we the turret head is slightly biased upward
    // Anchor.y += 8.0f / GetBitmapHeight();
}
void CoronaVirusTurret::CreateBullet() {
    Engine::Point diff = Engine::Point(cos(Rotation - ALLEGRO_PI / 2), sin(Rotation - ALLEGRO_PI / 2));
    float rotation = atan2(diff.y, diff.x);
    Engine::Point normalized = diff.Normalize();
    Engine::Point perpendicular;
    perpendicular.y = -normalized.x;
    perpendicular.x = normalized.y;
    // Change bullet position to the front of the gun barrel.
    if (BulletEmpty) {
        Bullet* bullet;
        getPlayScene()->BulletGroup->AddNewObject(bullet = new CoronaVirusBullet(Position + Engine::Point(CollisionRadius - GetBitmapHeight() / 2, 0), Engine::Point(0, 0), 0, this, 0));
        BulletArr[0] = bullet->Position;
        BulletPtr[0] = bullet;
        BulletStatus[0] = true;
        getPlayScene()->BulletGroup->AddNewObject(bullet = new CoronaVirusBullet(Position - Engine::Point(CollisionRadius - GetBitmapHeight() / 2, 0), Engine::Point(0, 0), 0, this, 1));
        BulletArr[1] = bullet->Position;
        BulletPtr[1] = bullet;
        BulletStatus[1] = true;
        getPlayScene()->BulletGroup->AddNewObject(bullet = new CoronaVirusBullet(Position + Engine::Point(0, CollisionRadius - GetBitmapHeight() / 2), Engine::Point(0, 0), 0, this, 2));
        BulletArr[2] = bullet->Position;
        BulletPtr[2] = bullet;
        BulletStatus[2] = true;
        getPlayScene()->BulletGroup->AddNewObject(bullet = new CoronaVirusBullet(Position - Engine::Point(0, CollisionRadius - GetBitmapHeight() / 2), Engine::Point(0, 0), 0, this, 3));
        BulletArr[3] = bullet->Position;
        BulletPtr[3] = bullet;
        BulletStatus[3] = true;
        bullet = nullptr;
        BulletEmpty = false;
    }
    else if (powerUp) {
        // std::cout << "kkkk\n";
        for (int i = 0; i < 4; i++) {
            if (!BulletStatus[i]) {
                getPlayScene()->BulletGroup->AddNewObject(BulletPtr[i] = new CoronaVirusBullet(BulletArr[i], Engine::Point(0, 0), 0, this, i));
                BulletStatus[i] = true;
            }
        }
    }
    else if (!BulletStatus[0] && !BulletStatus[1] && !BulletStatus[2] && !BulletStatus[3]) {
        for (int i = 0; i < 4; i++) {
            if (!BulletStatus[i]) {
                getPlayScene()->BulletGroup->AddNewObject(BulletPtr[i] = new CoronaVirusBullet(BulletArr[i], Engine::Point(0, 0), 0, this, i));
                BulletStatus[i] = true;
            }
        }
    }
}

void CoronaVirusTurret::Update(float deltaTime) {
    // if (powerUp) std::cout << "lll\n";
    PlayScene* scene = getPlayScene();
    imgBase.Position = Position;
    imgBase.Tint = Tint;
    if (!Enabled)
        return;
    // Shoot reload.
    reload -= deltaTime;
    // std::cout << reload << '\n';
    if (reload <= 0) {
        // shoot.
        reload = coolDown;
        CreateBullet();
    }
    Engine::Point PositionNext;
    for (int ID = 0; ID < 4; ID++) {
        PositionNext.x = (BulletArr[ID].x - Position.x) * cos(deltaTime) - (BulletArr[ID].y - Position.y) * sin(deltaTime);
        PositionNext.y = (BulletArr[ID].x - Position.x) * sin(deltaTime) + (BulletArr[ID].y - Position.y) * cos(deltaTime);
        BulletArr[ID] = Position + PositionNext;
    }
}

CoronaVirusTurret::~CoronaVirusTurret() {
    for (int i = 0; i < 4; i++) {
        if (BulletStatus[i] && !powerUp) {
            getPlayScene()->BulletGroup->RemoveObject(BulletPtr[i]->GetObjectIterator());
        }
    }
}