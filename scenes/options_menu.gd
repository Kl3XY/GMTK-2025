extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")
            
func _on_texture_button_pressed() -> void:
    print("optiones")
    visible = false;
    $"../Locker".visible = false;

            
