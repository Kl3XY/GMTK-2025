extends Node2D

var direction = Vector2.ZERO;

func _process(delta: float) -> void:
    _casterloop_proj_process(delta);

func _casterloop_proj_process(delta: float):
    position += direction * delta * 120;
    $AnimatedSprite2D.rotation = direction.angle();

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        body.health_component.Health -= 1;
        queue_free();


func _on_timer_timeout() -> void:
    queue_free()
