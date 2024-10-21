#ifndef ENEMY_HPP
#define ENEMY_HPP
#include <list>
#include <vector>
#include <string>

#include "Point.hpp"
#include "Sprite.hpp"

class Bullet;
class PlayScene;
class Turret;

class Enemy : public Engine::Sprite {
protected:
 	std::vector<Engine::Point> path;
	float speed;
	float maxSpeed;
	float hp;
	float slowRemainTime;
	int money;
	int level;
	PlayScene* getPlayScene();
	virtual void OnExplode();
public:
	float reachEndTime;
	std::list<Turret*> lockedTurrets;
	std::list<Bullet*> lockedBullets;
	Enemy(std::string img, float x, float y, float radius, float speed, float hp, int money, int _level);
 	virtual void Hit(float damage);
	void UpdatePath(const std::vector<std::vector<int>>& mapDistance);
	void Update(float deltaTime) override;
	void Draw() const override;
	void Slow(float slowFactor, float slowTime);
	void SlowEffect(float deltaTime);
	virtual void Upgrade();
};
#endif // ENEMY_HPP
