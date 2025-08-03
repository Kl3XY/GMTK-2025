extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")
var PLAYER_COLLECTED_GEMS = preload("res://Statistics/Statistics/Stats/Resources/player_collected_gems.tres")
func _ready() -> void:
    if $"../Shop/TextureRect/Label" != null:
        $"../Shop/TextureRect/Label".text = str(PLAYER_COLLECTED_GEMS.gems) + "x"

func _on_texture_button_pressed() -> void:
    print("optiones")
    visible = false;
    $%"Locker".visible = false;

            
