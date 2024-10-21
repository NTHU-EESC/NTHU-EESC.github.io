#ifndef PLUGGUNTURRET_HPP
#define PLUGGUNTURRET_HPP
#include "Turret.hpp"

class PlugGunTurret : public Turret {
public:
    static const int Price;
    PlugGunTurret(float x, float y);
    void CreateBullet() override;
};
#endif // PLUGGUNTURRET_HPP
