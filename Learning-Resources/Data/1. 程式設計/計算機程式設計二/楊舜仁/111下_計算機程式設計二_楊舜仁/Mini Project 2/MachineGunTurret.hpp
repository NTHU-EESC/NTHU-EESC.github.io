#ifndef MACHINEGUNTURRET_HPP
#define MACHINEGUNTURRET_HPP
#include "Turret.hpp"

class MachineGunTurret : public Turret {
public:
    static const int Price;
    static const int UpgradePrice;
    MachineGunTurret(float x, float y);
    MachineGunTurret(float x, float y, int level);
    void CreateBullet() override;
};
#endif // MACHINEGUNTURRET_HPP
