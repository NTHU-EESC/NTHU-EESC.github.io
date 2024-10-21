#include <allegro5/base.h>
#include <random>
#include <string>
#include <iostream>

#include "DirtyEffect.hpp"
#include "Enemy.hpp"
#include "CoronaVirusBullet.hpp"
#include "CoronaVirusTurret.hpp"
#include "Group.hpp"
#include "PlayScene.hpp"
#include "Point.hpp"
#include "Turret.hpp"
#include "Collider.hpp"

/*class Turret;*/

CoronaVirusBullet::CoronaVirusBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent, int id) :
    ID(id), Bullet("play/bullet-10.png", 750, 800, position, forwardDirection, rotation - ALLEGRO_PI / 2, parent) {
    // TODO 3 (2/5): You can imitate the 2 files: 'WoodBullet.hpp', 'WoodBullet.cpp' to create a new bullet.
}
void CoronaVirusBullet::OnExplode(Enemy* enemy) {
    std::random_device dev;
    std::mt19937 rng(dev());
    std::uniform_int_distribution<std::mt19937::result_type> dist(2, 5);
    getPlayScene()->GroundEffectGroup->AddNewObject(new DirtyEffect("play/dirty-1.png", dist(rng), enemy->Position.x, enemy->Position.y));
    parent->BulletStatus[ID] = false;
}

void CoronaVirusBullet::Update(float deltaTime) {
	/*Engine::Point PositionNext;
	PositionNext.x = (Position.x - parent->Position.x) * cos(deltaTime) - (Position.y - parent->Position.y) * sin(deltaTime);
	PositionNext.y = (Position.x - parent->Position.x) * sin(deltaTime) + (Position.y - parent->Position.y) * cos(deltaTime);
	parent->BulletArr[ID] = parent->Position + PositionNext;*/
	for (int i = 0; i < 4; i++) {
		std::cout << "x: " << parent->BulletArr[i].x << '\n';
	}
	Position = parent->BulletArr[ID];
	PlayScene* scene = getPlayScene();
	// Can be improved by Spatial Hash, Quad Tree, ...
	// However simply loop through all enemies is enough for this program.
	for (auto& it : scene->EnemyGroup->GetObjects()) {
		Enemy* enemy = dynamic_cast<Enemy*>(it);
		if (!enemy->Visible)
			continue;
		if (Engine::Collider::IsCircleOverlap(Position, CollisionRadius, enemy->Position, enemy->CollisionRadius)) {
			OnExplode(enemy);
			float tmp_damage = damage;
			getPlayScene()->BulletGroup->RemoveObject(objectIterator);
			enemy->Hit(tmp_damage);
			return;
		}
	}
}