extends Node2D

func _process(delta: float) -> void:
    $Area2D/CollisionShape2D.shape.radius += 60 * delta;


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Enemy:
        body.queue_free();
