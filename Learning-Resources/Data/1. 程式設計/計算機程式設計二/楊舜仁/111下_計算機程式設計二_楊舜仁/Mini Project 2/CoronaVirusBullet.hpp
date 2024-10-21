#ifndef CORONAVIRUSBULLET_HPP
#define CORONAVIRUSBULLET_HPP
#include "Bullet.hpp"

class Enemy;
class Turret;
namespace Engine {
    struct Point;
}  // namespace Engine

class CoronaVirusBullet : public Bullet {
public:
    int ID;
    explicit CoronaVirusBullet(Engine::Point position, Engine::Point forwardDirection, float rotation, Turret* parent, int id);
    void OnExplode(Enemy* enemy) override;
    void Update(float deltaTime) override;
};
#endif // CORONAVIRUSBULLET_HPP
