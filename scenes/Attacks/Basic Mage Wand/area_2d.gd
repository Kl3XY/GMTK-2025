extends Area2D

signal enemy_is_in_area_on_tick(enemy: Enemy)
@onready var basic_mage_wand: Node2D = $".."

func is_enemy(any) -> bool:
    return any is Enemy
    
func find_closest_enemy() -> Enemy:
    var bodies = get_overlapping_bodies().filter(is_enemy)
    
    if bodies.is_empty():
        return null
    
    return bodies.pick_random()

func _on_attack_timer_timeout() -> void:
    var stat = basic_mage_wand.playerStats as PlayerStats;
    $"../Attack Timer".wait_time = max(1.0 - (stat.attackSpeedSec), 0.001)
    var closest_enemy = find_closest_enemy();
    if find_closest_enemy():
        enemy_is_in_area_on_tick.emit(closest_enemy)
        
