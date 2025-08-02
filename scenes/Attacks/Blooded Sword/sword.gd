extends Sprite2D
@onready var attack_timer: Timer = $"../Attack Timer"

var perc = 0.0;

func _process(delta: float) -> void:
    _basic_mage_wand_process(delta);

func _basic_mage_wand_process(delta: float):
    rotation += delta * ((4 - attack_timer.time_left) * 15)
    perc = lerp(perc, 0.0, 12.0 * delta);
    material.set("shader_parameter/percentage", perc)
