#include <allegro5/base.h>
#include <cmath>
#include <string>

#include "AudioHelper.hpp"
#include "MachineBullet.hpp"
#include "Group.hpp"
#include "MachineGunTurret.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"
#include "ShootEffect.hpp"

const int MachineGunTurret::Price = 40;
MachineGunTurret::MachineGunTurret(float x, float y) :
    Turret("play/tower-base.png", "play/turret-1.png", x, y, 300, Price, 1.5) {
    // Move center downward, since we the turret head is slightly biased upward
    Anchor.y += 8.0f / GetBitmapHeight();
}

MachineGunTurret::MachineGunTurret(float x, float y, int level) :
    Turret("play/tower-base.png", "play/turret-" + std::to_string(level) + ".png", x, y, 380, Price, 1.5) {
    // Move center downward, since we the turret head is slightly biased upward
    Anchor.y += 8.0f / GetBitmapHeight();
}

void MachineGunTurret::CreateBullet() {
    Engine::Point diff = Engine::Point(cos(Rotation - ALLEGRO_PI / 2), sin(Rotation - ALLEGRO_PI / 2));
    float rotation = atan2(diff.y, diff.x);
    Engine::Point normalized = diff.Normalize();
    // Change bullet position to the front of the gun barrel.
    if (CollisionRadius == 300)
        getPlayScene()->BulletGroup->AddNewObject(new MachineBullet(Position + normalized * 36, diff, rotation, this));
    else {
        Engine::Point perpendicular(-normalized.y, normalized.x);
        getPlayScene()->BulletGroup->AddNewObject(new MachineBullet(Position + normalized * 36 + perpendicular * 9, diff, rotation, this));
        getPlayScene()->BulletGroup->AddNewObject(new MachineBullet(Position + normalized * 36 - perpendicular * 9, diff, rotation, this));
    }
    // TODO 4 (2/2): Add a ShootEffect here. Remember you need to include the class.
    getPlayScene()->EffectGroup->AddNewObject(new ShootEffect(Position.x + cos(Rotation - ALLEGRO_PI / 2) * GetBitmapWidth() / 2, Position.y + sin(Rotation - ALLEGRO_PI / 2) * GetBitmapWidth() / 2));

    AudioHelper::PlayAudio("gun.wav");
}
