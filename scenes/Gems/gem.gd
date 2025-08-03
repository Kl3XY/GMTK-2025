extends Node2D

var follow_player = false;

var player;
var speed = 30;
var xp_amount = 10;
var GET_GEM = preload("res://Achievements/Achievements/get_gem.tres")
var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")

func _ready() -> void:
    player = get_tree().get_first_node_in_group("player");

func _process(delta: float) -> void:
    _gem_orb_process(delta)
        
func _gem_orb_process(delta: float):
    rotation = sin(Time.get_ticks_msec() / 1000.0 * speed) * deg_to_rad(5)
    
    if follow_player:
        var dir = position.direction_to(player.position);
        speed += 600 * delta;
        position += dir * speed * delta
        $AnimatedSprite2D.rotation += 30 * delta;

func _on_player_collision_body_entered(body: Node2D) -> void:
    if body is Player:
        PLAYER_COLLECTED_GEMS.gems += 1;
        GET_GEM.hasUnlocked = true;
        call_deferred("queue_free");


func _on_timer_timeout() -> void:
    call_deferred("queue_free");


func _on_init_body_entered(body: Node2D) -> void:
    if body is Player:
        follow_player = true;
        $Init/CollisionShape2D.disabled = true;
