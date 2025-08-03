extends Attack

const ASIRA_WRATH = preload("res://scenes/Attacks/Amulet Of Asira/AsiraWrath.tscn")

func _on_timer_timeout() -> void:
    var inst = ASIRA_WRATH.instantiate();
    inst.position = global_position;
    inst.damage = playerStats.attack * 0.25;
    get_tree().current_scene.add_child(inst);  
