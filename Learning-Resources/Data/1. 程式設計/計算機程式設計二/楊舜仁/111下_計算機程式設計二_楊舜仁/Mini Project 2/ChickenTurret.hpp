#ifndef CHICKENTURRET_HPP
#define CHICKENTURRET_HPP
#include "Turret.hpp"

class ChickenTurret : public Turret {
public:
    static const int Price;
    ChickenTurret(float x, float y);
    void CreateBullet() override;
    bool BulletEmpty = true;
    void Update(float deltaTime) override;
};
#endif // CHICKENTURRET_HPP
