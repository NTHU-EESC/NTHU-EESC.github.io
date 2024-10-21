#ifndef TURRET_HPP
#define TURRET_HPP
#include <allegro5/base.h>
#include <list>
#include <string>

#include "Sprite.hpp"

class Enemy;
class PlayScene;

class Turret: public Engine::Sprite {
protected:
    int price;
    int upgradePrice;
    float coolDown;
    float reload = 0;
    float rotateRadian = 2 * ALLEGRO_PI;
    Sprite imgBase;
    std::list<Turret*>::iterator lockedTurretIterator;
    PlayScene* getPlayScene();
    // Reference: Design Patterns - Factory Method.
    virtual void CreateBullet() = 0;

public:
    bool Enabled = true;
    bool Preview = false;
    Enemy* Target = nullptr;
    Turret(std::string imgBase, std::string imgTurret, float x, float y, float radius, int price, float coolDown);
    void Update(float deltaTime) override;
    void Draw() const override;
	int GetPrice() const;
    bool BulletStatus[4] = {false, false, false, false};
    Engine::Point BulletArr[4] = { Engine::Point(-1, -1), Engine::Point(-1, -1), Engine::Point(-1, -1), Engine::Point(-1, -1) };
};
#endif // TURRET_HPP
