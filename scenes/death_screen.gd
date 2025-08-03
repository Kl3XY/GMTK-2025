extends CanvasLayer

func _process(delta: float) -> void:
    if visible:
        print($ColorRect.modulate.a)
        $ColorRect.color.a = lerp($ColorRect.color.a, 0.6, 0.085)

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/Main Menu.tscn")
