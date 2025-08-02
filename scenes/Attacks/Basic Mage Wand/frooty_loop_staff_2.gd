extends Sprite2D

var perc = 0.0;

func _process(delta: float) -> void:
    _basic_mage_wand_process(delta);

func _basic_mage_wand_process(delta: float):
    perc = lerp(perc, 0.0, 12.0 * delta);
    material.set("shader_parameter/percentage", perc)
