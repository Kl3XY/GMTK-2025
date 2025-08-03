extends Projectile


func _process(delta: float):
    rotation += 30 * delta;

func _on_area_2d_body_entered(body: Node2D) -> void:
     if body is Enemy:
        body.TookDamage.emit(damage, null);
