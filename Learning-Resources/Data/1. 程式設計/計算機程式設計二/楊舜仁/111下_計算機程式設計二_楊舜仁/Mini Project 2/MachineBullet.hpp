#ifndef MACHINEBULLET_HPP
#define MACHINEBULLET_HPP
#include "Bullet.hpp"

class Enemy;
class Turret;
namespace Engine {
    struct Point;
}  // namespace Engine

class MachineBullet : public Bullet {
public:
    explicit MachineBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent);
    void OnExplode(Enemy* enemy) override;
};
#endif // MACHINEBULLET_HPP
