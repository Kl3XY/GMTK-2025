extends Control


func _on_new_game_pressed() -> void:
    $ToDark.start = true;


func _on_exit_pressed() -> void:
    get_tree().quit()


func _on_new_game_mouse_entered() -> void:
    $AudioStreamPlayer2D.play();


func _on_achievements_mouse_entered() -> void:
    $AudioStreamPlayer2D.play();


func _on_extra_credits_mouse_entered() -> void:
    $AudioStreamPlayer2D.play();


func _on_options_mouse_entered() -> void:
    $AudioStreamPlayer2D.play();


func _on_exit_mouse_entered() -> void:
    $AudioStreamPlayer2D.play();
