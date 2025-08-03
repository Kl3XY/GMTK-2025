extends Attack

const NECROTIC_ATTACK = preload("res://scenes/Attacks/Necronomicon/Necrotic Attack.tscn")

func _on_timer_timeout() -> void:
    var inst = NECROTIC_ATTACK.instantiate();
    get_tree().current_scene.add_child(inst);
