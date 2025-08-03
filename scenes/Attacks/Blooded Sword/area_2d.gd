extends Area2D
@onready var blooded_sword: Node2D = $".."

signal enemy_is_in_area_on_tick(enemy: Enemy)
const SWORD_PROJECTILE = preload("res://scenes/Attacks/Blooded Sword/Sword_projectile.tscn")
func is_enemy(any) -> bool:
    return any is Enemy
    
func find_closest_enemy() -> Enemy:
    var bodies = get_overlapping_bodies().filter(is_enemy)
    
    if bodies.is_empty():
        return null
    
    return bodies.pick_random()

func _on_attack_timer_timeout() -> void:
    var stat = blooded_sword.playerStats as PlayerStats;
    $"../Attack Timer".wait_time = max(4.0 - (stat.attackSpeedSec), 0.5)
    
    var dirslice = 360 / 8;
    var ran = randi() * 360;
    for i in range(8):

        var inst = SWORD_PROJECTILE.instantiate();
        inst.position = global_position;
        inst.rotation = Vector2.RIGHT.rotated(dirslice * i).angle()
        inst.direction = Vector2.RIGHT.rotated(dirslice * i)
        inst.origin = self;
        inst.modify(get_tree().get_first_node_in_group("player").stats)
        get_tree().current_scene.add_child(inst);
