extends Area2D

const ATTACK = preload("res://scenes/Attacks/Attack.tscn")

var closest_enemy: Enemy;

func _physics_process(delta: float) -> void:
    closest_enemy = find_closest_enemy();
    
@onready var player = get_tree().get_first_node_in_group("player")
    
func find_closest_enemy() -> Enemy:
    var all_bodies = get_overlapping_bodies()
    var nearest_enemy: CharacterBody2D;
    var nearest_enemy_distance: float = INF;
    
    for body in all_bodies:
        if body is Enemy:
            if player.global_position.distance_to(body.position) < nearest_enemy_distance:
                nearest_enemy_distance = player.global_position.distance_to(body.position);
                nearest_enemy = body;
    
    return nearest_enemy;


func _on_attack_timer_timeout() -> void:
    if closest_enemy != null:
        var inst = ATTACK.instantiate();
        inst.direction = global_position.direction_to(closest_enemy.position);
        inst.position = global_position;
        get_tree().current_scene.add_child(inst);
