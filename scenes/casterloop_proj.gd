extends Node2D

var direction = Vector2.ZERO;

func _process(delta: float) -> void:
    position += direction * delta * 120;
    $AnimatedSprite2D.rotation = direction.angle();


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        body.health_component.Health -= 1;
        queue_free();
