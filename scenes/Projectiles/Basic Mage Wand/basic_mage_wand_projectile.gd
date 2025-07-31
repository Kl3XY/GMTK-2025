extends Projectile

const DAMAGE_NUMBER = preload("res://scenes/UI/DamageNumber.tscn")

func _on_damage_area_body_entered(body: Node2D):
    if body is Enemy:
        body.queue_free();
        queue_free();
        var dmgNumInst = DAMAGE_NUMBER.instantiate();
        dmgNumInst.position = body.position;
        get_tree().current_scene.add_child(dmgNumInst);

func _process(delta: float) -> void:
    rotation = direction.angle();
    position += direction * 300.0 * delta;
