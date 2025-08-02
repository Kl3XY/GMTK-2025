extends NinePatchRect

func _on_texture_button_pressed() -> void:
    visible = false;
    $"../Locker".visible = false;
