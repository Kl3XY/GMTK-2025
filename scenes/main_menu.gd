extends Control

var DIFFICULTY = preload("res://Difficulty/difficulty.tres")

func _on_new_game_pressed() -> void:
    $ToDark.start = true;
    DIFFICULTY.difficulty = 2.0;


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
