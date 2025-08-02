extends NinePatchRect

var reload_info: bool = true;

const HANDLER = preload("res://Achievements/Handler.tres")

func _process(delta: float) -> void:
    pass
            
func _on_texture_button_pressed() -> void:
    visible = false;
    $"../Locker".visible = false;

            
