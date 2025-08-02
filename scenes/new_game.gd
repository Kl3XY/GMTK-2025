extends Button


func _on_pressed() -> void:
    $"../../..".visible = false;
    Engine.time_scale = 1.0;
