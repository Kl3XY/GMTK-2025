extends ColorRect

var start: bool = false;

func _process(delta: float):
    print(modulate.a)
    visible = true; # nur damit ich es im editor disablen kann damit es nicht nerft lmao
    modulate.a = lerp(modulate.a, -0.1, delta)
    if modulate.a <= 0:
        queue_free()
