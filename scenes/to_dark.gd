extends ColorRect

var start: bool = false;

func _process(delta: float):
    visible = start;
    if start:
        color.a = lerp(color.a, 1.1, 10 * delta)
        if color.a >= 1:
            color.a == 1;
            get_tree().change_scene_to_file("res://scenes/World.tscn");
