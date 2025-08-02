extends ColorRect

var start: bool = false;

func _process(delta: float):
    print(modulate.a)
    modulate.a = lerp(modulate.a, -0.1, delta)
    if modulate.a <= 0:
        queue_free()
