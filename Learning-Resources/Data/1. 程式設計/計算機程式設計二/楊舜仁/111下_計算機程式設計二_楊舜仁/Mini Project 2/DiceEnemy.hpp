#ifndef DICEENEMY_HPP
#define DICEENEMY_HPP
#include "Enemy.hpp"

class DiceEnemy : public Enemy {
public:
    int level;
    DiceEnemy(int x, int y, int _level);
};
#endif // DICEENEMY_HPP