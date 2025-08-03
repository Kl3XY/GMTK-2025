extends "res://scenes/Enemies/area_2d.gd"

func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        body.TakeDamage.emit(65, null);
