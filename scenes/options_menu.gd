extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")
var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")
func _ready() -> void:
    var bus = AudioServer.get_bus_index("Master")
    $Label/HSlider.value = AudioServer.get_bus_volume_linear(bus);

func _on_texture_button_pressed() -> void:
    visible = false;
    $%"Locker".visible = false;

func _on_visibility_changed() -> void:
    var bus = AudioServer.get_bus_index("Master")
    $Label/HSlider.value = AudioServer.get_bus_volume_linear(bus);

func _on_h_slider_value_changed(value: float) -> void:
    var bus = AudioServer.get_bus_index("Master")

    AudioServer.set_bus_volume_linear(bus, value)
