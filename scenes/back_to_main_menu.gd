extends Button


func _on_pressed() -> void:
    $%"ToDark".start = true;
    Engine.time_scale = 1.0;
