extends Sprite2D

var perc = 0.0;

func _process(delta: float) -> void:
    perc = lerp(perc, 0.0, 3 * delta);
    material.set("shader_parameter/percentage", perc)
