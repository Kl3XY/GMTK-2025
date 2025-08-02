extends Attack

const BASIC_MAGE_WAND_PROJECTILE = preload("res://scenes/Projectiles/Basic Mage Wand/Basic Mage Wand Projectile.tscn")

func _on_area_2d_enemy_is_in_area_on_tick(enemy: Enemy) -> void:
    var inst = BASIC_MAGE_WAND_PROJECTILE.instantiate();
    inst.direction = global_position.direction_to(enemy.position);
    inst.position = global_position + inst.direction * 7;
    get_tree().current_scene.add_child(inst);
    $FrootyLoopStaff2.perc = 0.5;
