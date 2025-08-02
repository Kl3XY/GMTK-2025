extends Area2D

signal enemy_is_in_area_on_tick(enemy: Enemy);
    
func find_closest_enemy() -> Enemy:
    var all_bodies = get_overlapping_bodies()
    var nearest_enemy: CharacterBody2D;
    var nearest_enemy_distance: float = INF;
    
    for body in all_bodies:
        if body is Enemy:
            if global_position.distance_to(body.position) < nearest_enemy_distance:
                nearest_enemy_distance = global_position.distance_to(body.position);
                nearest_enemy = body;
    
    return nearest_enemy;


func _on_attack_timer_timeout() -> void:
    var closest_enemy = find_closest_enemy();
    if find_closest_enemy():
        enemy_is_in_area_on_tick.emit(closest_enemy);
        
