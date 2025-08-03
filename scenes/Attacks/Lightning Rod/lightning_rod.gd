extends Attack

const LIGHTNING = preload("res://scenes/Attacks/Lightning Rod/Lightning.tscn")

func _on_timer_timeout() -> void:
    var stat = playerStats as PlayerStats;
    $Timer.wait_time = max(1.5 - (stat.attackSpeedSec), 0.3)
    
    var player = get_tree().get_first_node_in_group("player");
    
    var inst = LIGHTNING.instantiate();
    inst.modify(playerStats)
    var _x = randf_range(-64, 64);
    var _y = randf_range(-64, 64);
    
    inst.position = player.position + Vector2(_x, _y)
    get_tree().current_scene.add_child(inst)
