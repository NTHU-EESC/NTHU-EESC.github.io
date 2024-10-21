#ifndef MINER_HPP
#define MINER_HPP
#include "Turret.hpp"

class Miner : public Turret {
public:
    static const int Price;
    Miner(float x, float y);
    void CreateBullet();
};
#endif // MINER_HPP
