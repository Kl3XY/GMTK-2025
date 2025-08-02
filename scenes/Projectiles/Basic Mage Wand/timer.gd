extends Timer


func _on_timeout() -> void:
    $"..".call_deferred("queue_free")
