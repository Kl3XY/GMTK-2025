extends Projectile


func _on_animated_sprite_2d_animation_looped() -> void:
    queue_free()

func modify(stats: PlayerStats):
    damage = stats.attack;

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Enemy:
        (body as Enemy).TookDamage.emit(damage, null);
