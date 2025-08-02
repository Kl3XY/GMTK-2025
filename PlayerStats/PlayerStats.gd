extends Resource
class_name PlayerStats

@export var attack = 30;
@export var speed = 80;

func add(stats: PlayerStats):
    attack += stats.attack;
    speed += stats.speed;
