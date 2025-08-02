extends Area2D

signal enemy_is_in_area_on_tick(enemy: Enemy)
    
func is_enemy(any) -> bool:
    return any is Enemy
    
func find_closest_enemy() -> Enemy:
    var bodies = get_overlapping_bodies().filter(is_enemy)
    
    if bodies.is_empty():
        return null
    
    return bodies.pick_random()

func _on_attack_timer_timeout() -> void:
    var closest_enemy = find_closest_enemy();
    if find_closest_enemy():
        enemy_is_in_area_on_tick.emit(closest_enemy)
        
