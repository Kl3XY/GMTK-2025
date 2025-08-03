extends AudioStreamPlayer2D
class_name AudioManager;

var should_die = false;

func emit() -> void:
    play()
    reparent(get_tree().current_scene);
    should_die = true

func _on_finished() -> void:
    if should_die == true:
        queue_free();
