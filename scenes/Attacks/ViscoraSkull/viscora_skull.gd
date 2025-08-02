extends Attack

const VISCORA_SKULL_PROJECTILE = preload("res://scenes/Attacks/ViscoraSkull/ViscoraSkullProjectile.tscn")
@onready var viscora_skull: Node2D = $"."

func is_enemy(any) -> bool:
    return any is Enemy
    
func find_closest_enemy() -> Enemy:
    var bodies = $Area2D.get_overlapping_bodies().filter(is_enemy)
    
    if bodies.is_empty():
        return null
    
    return bodies.pick_random()


func _on_timer_timeout() -> void:
    var enemy = find_closest_enemy();
    
    var stat = viscora_skull.playerStats as PlayerStats;
    $Timer.wait_time = max(3.0 - (stat.attackSpeedSec), 0.3)
    
    if enemy != null:
        var inst = VISCORA_SKULL_PROJECTILE.instantiate();
        inst.position = global_position;
        inst.direction = global_position.direction_to(enemy.position)
        get_tree().current_scene.add_child(inst);
