extends CanvasLayer

func _process(delta: float) -> void:
    $ColorRect.color.a = lerp($ColorRect.color.a, 0.0, 24 * delta);
