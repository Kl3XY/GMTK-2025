extends Area2D


func _on_body_entered(body: Node2D) -> void:
    print(body.name)
    if body is Player:
        print("sdasdsdasdasd")
        body.TakeDamage.emit(5, null);
