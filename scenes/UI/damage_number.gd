extends Control

@onready var label: Label = $Label

var speed = 300.0;

func _process(delta: float) -> void:
    label.scale = lerp(label.scale, Vector2(1, 1), 13.0 * delta)
    speed = lerp(speed, 0.0, 10.0 * delta)
    position.y -= speed * delta;


func _on_timer_timeout() -> void:
    queue_free()
