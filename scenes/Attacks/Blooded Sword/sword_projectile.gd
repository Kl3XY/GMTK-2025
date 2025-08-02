extends Projectile

var origin: Node2D;
var return_to_point: bool = false;

func _process(delta: float) -> void:
    if return_to_point == false:
        position += direction * speed * delta;
        speed = lerp(speed, 0.0, 2.0 * delta);
    else:
        var plr = get_tree().get_first_node_in_group("player");
        modulate.a -= 2 * delta;
        rotation = position.direction_to(plr.position).angle()
        position += position.direction_to(plr.position) * 30 * delta;
        if modulate.a < 0.3:
            call_deferred("queue_free")

func _on_return_timeout() -> void:
    return_to_point = true;

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Enemy:
        body.TookDamage.emit(damage, get_tree().get_first_node_in_group("player"));
        call_deferred("queue_free");

func modify(stats: PlayerStats):
    damage = stats.attack * 0.135;
