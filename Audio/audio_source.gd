extends AudioStreamPlayer2D
class_name AudioManager;

func emit() -> void:
    play()
    reparent(get_tree().current_scene);

func _on_finished() -> void:
    queue_free();
