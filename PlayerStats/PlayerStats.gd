extends Resource
class_name PlayerStats

@export var attack = 30;
@export var speed = 80;
@export var attackSpeedSec = 0.0;

func add(stats: PlayerStats):
    attack += stats.attack;
    speed += stats.speed;
    attackSpeedSec += stats.attackSpeedSec;
