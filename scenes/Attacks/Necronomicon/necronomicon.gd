extends Attack

const NECROTIC_ATTACK = preload("res://scenes/Attacks/Necronomicon/Necrotic Attack.tscn")

func _on_timer_timeout() -> void:
    var stat = playerStats as PlayerStats;
    $Timer.wait_time = max(5.0 - (stat.attackSpeedSec), 0.3)
    var inst = NECROTIC_ATTACK.instantiate();
    inst.modify(playerStats)
    get_tree().current_scene.add_child(inst);
