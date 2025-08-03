extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")
var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")
func _ready() -> void:
    var bus = AudioServer.get_bus_index("Master")
    if $"../Shop/TextureRect/Label" != null:
        $"../Shop/TextureRect/Label".text = str(PLAYER_COLLECTED_GEMS.gems) + "x"

func _on_texture_button_pressed() -> void:
    print("optiones")
    visible = false;
    $%"Locker".visible = false;


func _on_music_volume_2_drag_ended(value_changed: bool) -> void:
    var bus = AudioServer.get_bus_index("Master")
    AudioServer.set_bus_volume_db(bus, linear_to_db(value_changed))
