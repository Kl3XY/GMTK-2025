extends Projectile

func _on_damage_area_body_entered(body: Node2D):
    if body is Enemy:
        body.queue_free();
        queue_free();

func _process(delta: float) -> void:
    rotation = direction.angle();
    position += direction * 300.0 * delta;
