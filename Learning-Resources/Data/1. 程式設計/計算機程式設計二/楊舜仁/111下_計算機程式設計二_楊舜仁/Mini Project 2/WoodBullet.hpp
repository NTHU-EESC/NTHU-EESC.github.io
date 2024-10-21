#ifndef WOODBULLET_HPP
#define WOODBULLET_HPP
#include "Bullet.hpp"

class Enemy;
class Turret;
namespace Engine {
    struct Point;
}  // namespace Engine

class WoodBullet : public Bullet {
public:
    explicit WoodBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent);
    void OnExplode(Enemy* enemy) override;
};
#endif // WOODBULLET_HPP
