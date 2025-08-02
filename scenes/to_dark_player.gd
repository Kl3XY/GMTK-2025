extends ColorRect

var start: bool = false;

func _process(delta: float):
    modulate.a = lerp(modulate.a, -0.1, 10 * delta)
    if modulate.a <= 0:
        queue_free()
