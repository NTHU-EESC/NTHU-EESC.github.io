#ifndef CORONAVIRUSTURRET_HPP
#define CORONAVIRUSTURRET_HPP
#include "Turret.hpp"
#include "Bullet.hpp"

class CoronaVirusTurret : public Turret {
public:
    Bullet* BulletPtr[4];
    static const int Price;
    CoronaVirusTurret(float x, float y);
    ~CoronaVirusTurret();
    void CreateBullet() override;
    bool BulletEmpty = true;
    void Update(float deltaTime) override;
};
#endif // CORONAVIRUSTURRET_HPP
