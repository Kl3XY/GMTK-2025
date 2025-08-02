extends Node2D
class_name Projectile

@export var direction: Vector2;
@export var damage = 30;
@export var speed = 80;

func modify(stats: PlayerStats):
    damage = stats.attack;
