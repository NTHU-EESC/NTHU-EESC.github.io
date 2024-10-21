#include <string>
#include <iostream>

#include "DiceEnemy.hpp"
#include "Turret.hpp"
#include "Bullet.hpp"
#include "PlayScene.hpp"
#include "AudioHelper.hpp"
#include "Group.hpp"

DiceEnemy::DiceEnemy(int x, int y, int _level) : Enemy("play/dice-" + std::to_string(_level) + ".png", x, y, 25, 55 + 25 * (6 - _level), 7 * _level / 3, 10, _level) {}