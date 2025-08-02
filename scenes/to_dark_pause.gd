extends ColorRect

var start: bool = false;

func _process(delta: float):
    visible = start;
    if start:
        print(modulate.a)
        modulate.a = lerp(modulate.a, 1.0, 5 * delta)
        if modulate.a >= 0.9:
            get_tree().change_scene_to_file("res://scenes/Main Menu.tscn");
